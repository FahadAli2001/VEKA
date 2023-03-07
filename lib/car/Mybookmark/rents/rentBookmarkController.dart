import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../SignIn/SignInController.dart';

class rentBookmarkController extends GetxController {


  SignInController sic = Get.put(SignInController());

  var isBookmarked = false.obs;
  var iconColor = Colors.grey.obs;
  var sharekey;
  var BookmarkId = [];
  var pid;
  var data;
  void onInit() {
    // Initialization logic goes here
    super.onInit();
    //getSharekey();
   // getBookmarksData();
  }
  getsharekeybyId(pid) async{
    var  id = sic.userId.toString();
    final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/$id";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );
    if(response.statusCode == 200){

      var data = jsonDecode(response.body.toString());
      sharekey = data[0]["share_key"];
      print(sharekey);
     // print(data.toString());
      addBookmark(pid);
    }else{
      print("get api ${response.statusCode}");
    }


  }

  addBookmark(pid)async{
    print("sharekey ${sharekey}");
    final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$sharekey/add_product";
    print(url);
    print(pid);
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
          'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
        body: jsonEncode({
          "product_id": pid,
          "variation_id": 0,
          "meta": {
          }
        }),
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data.toString());
        print("added");
      }else{
        var data = jsonDecode(response.body.toString());
        print("post api ${response.statusCode}");
        print(data);
      }
    }catch (e){
      print("something went wrong");
    }

  }

  getSharekey()async{
    var  id = sic.userId.toString();
    final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/$id";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );
    if(response.statusCode == 200){

      var data = jsonDecode(response.body.toString());
      sharekey = data[0]["share_key"];
      print(sharekey);
      // print(data.toString());
      getBookmarksData();
    }else{
      print("get api ${response.statusCode}");
    }

  }
  getBookmarksData()async{

    //print(sharekey);
    final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$sharekey/get_products";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );
    if(response.statusCode == 200){

      var data = jsonDecode(response.body.toString());
      print(data);

      for(var product in data){
         pid = product["product_id"];
       // print(pid);
        BookmarkId.add(pid);
      }
      print(BookmarkId);
      getAllData();
     // print(pid);

    }else{
      print("get api ${response.statusCode}");
    }

  }

  getAllData()async{
    final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products?include=$BookmarkId";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );
    if(response.statusCode == 200){

       data = jsonDecode(response.body.toString());
      print(data);


    }else{
      print("get api ${response.statusCode}");
    }
    return data;
  }






}









class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});



}
