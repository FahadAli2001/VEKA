import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class sellHomeController extends GetxController{
  var buyproducts;

  Future buyProduct()async
  {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: "ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8",
          consumerSecret: "cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37");
      buyproducts = await wooCommerceAPI.getAsync("products?type=simple");//?type=ovacrs_car_rental
      // print(rentproducts);

    }
    catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey

      );
      print(e);
    }
    return buyproducts;
  }

  Future<void> toggleBookmark(String productId, String productName,
      String productPrice, String productImage,) async {
    try {

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // user not signed in
        return;
      }
      print("funtion called");
      // reference to bookmarks collection for this user
      final bookmarksRef = FirebaseFirestore.instance
          .collection('buyHouse-bookmarks')
          .doc(user.uid)
          .collection('productIds')
          .doc(productId);

      // check if product is already bookmarked
      final snapshot = await bookmarksRef.get();

      if (snapshot.exists) {

        await bookmarksRef.delete();

        print('Bookmark removed for product ');
      } else {
        await bookmarksRef.set({
          'name': productName,
          'price': productPrice,
          'image': productImage,
          "id":productId
        }, SetOptions(merge: true));
        print('Bookmark added for product');
      }
    } catch (e) {
      print("error ${e.toString()}");
    }
  }


}