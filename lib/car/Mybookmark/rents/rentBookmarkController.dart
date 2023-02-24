import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SignIn/SignInController.dart';

class rentBookmarkController extends GetxController{

  SignInController sic = Get.put(SignInController());

  var isbookedmark = false.obs;

  Future<void> toggleBookmark(String productId, String productName, String productPrice, String productImage,) async {
    //SharedPreferences rentBookmarksp =await SharedPreferences.getInstance();
    // get current user
    SharedPreferences bmvalue = await SharedPreferences.getInstance();

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
      // already bookmarked, so remove it
      await bookmarksRef.delete();
      isbookedmark.value = false;

      //print(bmvalue.getBool("isBookmark"));
      bmvalue.setBool("isBookmark", isbookedmark.value);
      print('Bookmark removed for product ');
      print(isbookedmark.value);
      print(bmvalue.getBool("isBookmark"));
    } else {
      // product not bookmarked yet, so add it
      await bookmarksRef.set({
        'name': productName,
        'price': productPrice,
        'image': productImage,
        'isBookmark': true
      }, SetOptions(merge: true));
      print('Bookmark added for product');
     // isbookedmark.value = true;
      //rentBookmarksp.setBool("isBookmark", isbookedmark.value);
    }

    final isBookmarkSnapshot = await bookmarksRef.get();
    if (isBookmarkSnapshot.exists) {
       isbookedmark.value = isBookmarkSnapshot.data()!['isBookmark'] ?? false;
       print(isbookedmark.value);

       bmvalue.setBool('isBookmark', isbookedmark.value);
       print(bmvalue.getBool('isBookmark'));

    }
  }



/*List rentBookmarkList = [];

    var bookmarkColor = Colors.grey.obs;
    List<String>? bookmarkList;

    Future<List<dynamic>> getBookmarks() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        String? bookmarkData = prefs.getString('rent_bookmark');
        if (bookmarkData != null) {
          List<dynamic> bookmarkList = json.decode(bookmarkData) as List<dynamic>;
          for (var bookmark in bookmarkList) {
            if (bookmark is Map<String, dynamic>) {
              print(bookmark['id']);
              print(bookmark['title']);
              print(bookmark['url']);
              // Add any additional fields you want to print here
            }
          }
          return bookmarkList;
        }
      } catch (e) {
        print('Error retrieving bookmarks: $e');
      }

      return [];
    }



    bookmark(rentbookmarkModel model) async {
      SharedPreferences rentbookmark =await  SharedPreferences.getInstance();
      var id = model.id;
      if (rentBookmarkList.any((item) => item.id == id)) {
        print("contain");
        rentBookmarkList.remove(model);
        List bookmarkList = rentBookmarkList.map((item) => item.toJson()).toList();
        String jsonString = jsonEncode(bookmarkList);
        List<String> stringList = [jsonString];
        rentbookmark.setStringList("rent_bookmark", stringList);
        print("deleted");
        bookmarkColor.value = Colors.grey;
      } else {
        print("not contain");
        rentBookmarkList.add(model);
        List bookmarkList = rentBookmarkList.map((item) => item.toJson()).toList();
        String jsonString = jsonEncode(bookmarkList);
        List<String> stringList = [jsonString];
        rentbookmark.setStringList("rent_bookmark", stringList);
        bookmarkColor.value = Colors.red;
        print("added");
      }
    }


   List RentBookmarkList = [];



  void checkModel(rentbookmarkModel model) async{
    if (RentBookmarkList.contains(model)) {
      print("${model.name} exists in the list");
      RentBookmarkList.remove(model);
      print(" removed");
    } else {
      print("${model.name} does not exist in the list");
        RentBookmarkList.add(model);
      final prefs = await SharedPreferences.getInstance();

      var listJson = RentBookmarkList.map((model) => json.encode(model.toJson())).toList();

      await prefs.setStringList('rent_bookmark_list', listJson);
    }
      print(" added");
    }*/
}








class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});



}
