import 'dart:convert';
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../../car/Token/AccessToken.dart';

class sellHomeController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  var buyproducts;
  RxBool isLoad = false.obs;
  var userName = "".obs;
  var image = "".obs;
  var allProduct;
  var accessToken;

  Future buyProduct() async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: "ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8",
          consumerSecret: "cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37");
      buyproducts = await wooCommerceAPI
          .getAsync("products?type=simple"); //?type=ovacrs_car_rental
      // print(rentproducts);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      print(e);
    }
    return buyproducts;
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getInt("realStateUserId").toString();

    isLoad.value = true;
    allProduct = await buyProduct();
    isLoad.value = false;
    // if (pref.getString("image") != null) {
    //   print("working");
    //   print("image");
    //   userName.value = pref.getString("username")!;
    //   image.value = pref.getString("image")!;
    //   print(image.value);
    //   print(userName.value);
    // } else {
    userName.value = "Guest";
    getAcessToken(userId);
    // }

    userName.value = pref.getString("username")!;
  }

  Future getAcessToken(String userId) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessToken.RealStateusername,
            "password": acessToken.RealStatepassword
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];

        getUserData(accessToken!, userId);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
    return accessToken;
  }

  Future getUserData(String accessToken, String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences pref = await SharedPreferences.getInstance();

        userName.value = data["username"];
        data["meta_data"].forEach((element) {
          if (element["key"] == "my_url") {
            image.value = element["value"];
          }
        });

        pref.setString("username", userName.value);
        pref.setString("image", image.value);
      } else {
        print("error ${response.statusCode}");
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.black);
      }
    } catch (e) {
      print("catch error : $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
  }

  // Future<void> toggleBookmark(
  //   String productId,
  //   String productName,
  //   String productPrice,
  //   String productImage,
  // ) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       // user not signed in
  //       return;
  //     }
  //     print("funtion called");
  //     // reference to bookmarks collection for this user
  //     final bookmarksRef = FirebaseFirestore.instance
  //         .collection('buyHouse-bookmarks')
  //         .doc(user.uid)
  //         .collection('productIds')
  //         .doc(productId);

  //     // check if product is already bookmarked
  //     final snapshot = await bookmarksRef.get();

  //     if (snapshot.exists) {
  //       await bookmarksRef.delete();

  //       print('Bookmark removed for product ');
  //     } else {
  //       await bookmarksRef.set({
  //         'name': productName,
  //         'price': productPrice,
  //         'image': productImage,
  //         "id": productId
  //       }, SetOptions(merge: true));
  //       print('Bookmark added for product');
  //     }
  //   } catch (e) {
  //     print("error ${e.toString()}");
  //   }
  // }
}
