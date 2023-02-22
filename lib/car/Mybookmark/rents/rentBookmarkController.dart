import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class rentBookmarkController extends GetxController{

  void addBookMark()async{

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


 /* List RentBookmarkList = [];



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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'image':image
  };*/

}
