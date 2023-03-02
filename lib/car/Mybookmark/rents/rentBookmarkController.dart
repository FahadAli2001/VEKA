import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SignIn/SignInController.dart';

class rentBookmarkController extends GetxController {


  SignInController sic = Get.put(SignInController());
  var isBookmarked = false.obs;
  //var iconColor = Rx<MaterialColor?>(null);

  var iconColor = Colors.grey.obs;
  @override
  void onInit()async{

  }


  /*@override
  void onInit() async {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final bookmarksRef = FirebaseFirestore.instance
        .collection('rentalCar-bookmarks')
        .doc(user.uid)
        .collection('productIds')
        .doc(productId);

    // listen for changes to bookmarks collection
    final snapshot =await bookmarksRef.get();
    SharedPreferences rentBookmarksp = await SharedPreferences.getInstance();
    if (snapshot.exists) {
      iconColor.value = Colors.red;
      rentBookmarksp.setInt("IconColor", iconColor.value!.value);
    } else {
      iconColor.value = Colors.grey;
      rentBookmarksp.setInt("IconColor", iconColor.value!.value);
    }

  }*/

  /*@override
  void onInit() async {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final bookmarksRef = FirebaseFirestore.instance
        .collection('rentalCar-bookmarks')
        .doc(user.uid)
        .collection('productIds')
        .doc(productId);

    // listen for changes to bookmarks collection
    final snapshot = await bookmarksRef.get();
    if(snapshot.exists){
      iconColor.value ??= Colors.red; // add null check here
    }else{
      iconColor.value ??= Colors.grey; // add null check here
    }
  }*/

 /* @override
  void onInit() async {
    super.onInit();

    SharedPreferences rentBookmarksp = await SharedPreferences.getInstance();
    int? savedColor = rentBookmarksp.getInt("IconColor");

    // if savedColor is not null, set the value of iconColor to the saved color
    if (savedColor != null) {
      iconColor.value = MaterialColor(savedColor, {});
    }
  }*/



    /*Future<void> toggleBookmark(String productId, String productName,
        String productPrice, String productImage,) async {
      try {
         SharedPreferences rentBookmarksp =await SharedPreferences.getInstance();
        //SharedPreferences rentBookmarksp = await SharedPreferences.getInstance();
        // get current users

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          // user not signed in
          return;
        }

        // reference to bookmarks collection for this user
        final bookmarksRef = FirebaseFirestore.instance
            .collection('rentalCar-bookmarks')
            .doc(user.uid)
            .collection('productIds')
            .doc(productId);

        // check if product is already bookmarked
        final snapshot = await bookmarksRef.get();
        if (snapshot.exists) {

          await bookmarksRef.delete();
          iconColor.value = Colors.grey;

          rentBookmarksp.setBool("bookmark", false);
          print('Bookmark removed for product ');
        } else {
          await bookmarksRef.set({
            'name': productName,
            'price': productPrice,
            'image': productImage,
          }, SetOptions(merge: true));
          print('Bookmark added for product');
          iconColor.value = Colors.red;
          isBookmarked.value = true;
          bool? getbool = rentBookmarksp.getBool("bookmark");
          rentBookmarksp.setBool("bookmark", !getbool!);
          /*SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> bookmarkedProductIds = prefs.getStringList('bookmarkedProductIds') ?? [];
          if (isBookmarked.value) {
            bookmarkedProductIds.add(productId);
          } else {
            bookmarkedProductIds.remove(productId);
          }
          await prefs.setStringList('bookmarkedProductIds', bookmarkedProductIds);*/
        }
      } catch (e) {
        print(e);
      }
    }*/

  Future<void> toggleBookmark(String productId, String productName,
      String productPrice, String productImage,) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // user not signed in
        return;
      }

      // reference to bookmarks collection for this user
      final bookmarksRef = FirebaseFirestore.instance
          .collection('rentalCar-bookmarks')
          .doc(user.uid)
          .collection('productIds')
          .doc(productId);

      // check if product is already bookmarked
      final snapshot = await bookmarksRef.get();
      if (snapshot.exists) {

        await bookmarksRef.delete();
        iconColor.value = Colors.grey;

        print('Bookmark removed for product ');
      } else {
        await bookmarksRef.set({
          'name': productName,
          'price': productPrice,
          'image': productImage,
          "id":productId
        }, SetOptions(merge: true));
        print('Bookmark added for product');
        iconColor.value = Colors.red;

      }
    } catch (e) {
      print(e);
    }
  }

}









class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});



}
