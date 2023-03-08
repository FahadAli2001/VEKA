import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
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
    //getSharekey();
   // getsharekeybyId(pid);
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


  getBookmarksData()async{
    getsharekeybyId(pid);
    print(sharekey);
   try{
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
       for (final product in data) {
         final productId = product["product_id"] as int;
         BookmarkId.add(productId);
       }

       //final products = await fetchProducts();
       //return products;

     }else{
       var data = jsonDecode(response.body.toString());
       print(data);
       print("bookmarks get api ${response.statusCode}");
     }
   }catch (e){
     print("getbookmark data error : ${e}");
   }

  }
  var allProduct;
  Future allproducts()async
  {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
      allProduct = await wooCommerceAPI.getAsync("products");
      print(allProduct);


    }
    catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey
      );
    }
    return allProduct;
  }

  fetchProducts() async {
   try{
     var headers = {
       'Cookie': 'tinv_wishlistkey=7380a2; tinvwl_wishlists_data_counter=0'
     };
     var request = http.Request('GET', Uri.parse('https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products?oauth_consumer_key=ck_35efc60387133919ea7a6e22c34a2201af711f47&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1678289532&oauth_nonce=HhAUPuMwp6l&oauth_version=1.0&oauth_signature=77vgDrO4rE7nShBR7eQWzM9ulkg%3D'));

     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }


   }catch (e){
     print("error : ${e.toString()}");
   }

    // print("fetch product");
    //print(BookmarkId);
   /* final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products?include=3693";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication': 'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );

    if (response.statusCode == 200) {
      final productData = jsonDecode(response.body);
      print(productData.toString());
    } else {
      print("fetch get api  ${response.statusCode}");
    }*/
  }






}









class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});



}
