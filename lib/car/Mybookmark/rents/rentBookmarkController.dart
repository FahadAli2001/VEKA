import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../SignIn/SignInController.dart';

class rentBookmarkController extends GetxController {


  SignInController sic = Get.put(SignInController());

  var isBookmarked = false.obs;

  //var iconColor = Rx<MaterialColor?>(null);

  var iconColor = Colors.grey.obs;

  var sharekey;


  /*Future<void> toggleBookmark(String productId, String productName,
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
  }*/

  /*getShareKey() async {
    var headers = {
      //'Cookie': 'tinv_wishlistkey=7380a2; tinvwl_wishlists_data_counter=0',
      'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
      'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
    };
    var request = http.Request('GET', Uri.parse('https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/34'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

    /*  try {

      //final url = "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products";
      //print("URL: $url");
      final response = await http.get(
        Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products"),
        headers: {
          'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
          'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
        },
      );
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        //var data = jsonDecode(response.body.toString());
        //sharekey = data["share_key"];
        //print(sharekey);
      } else {
        var data = jsonDecode(response.body.toString());
        print(response.statusCode);
        print(data);
      }
    } catch (e) {
      print("error");
      print(e.toString());
    }*/
    return sharekey;
  }*/



  /*
  var headers = {
  'Cookie': 'tinv_wishlistkey=7380a2; tinvwl_wishlists_data_counter=0'
};
var request = http.Request('GET', Uri.parse('https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/34?oauth_consumer_key=ck_35efc60387133919ea7a6e22c34a2201af711f47&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1678122179&oauth_nonce=AfwzdQE8Mkm&oauth_version=1.0&oauth_signature=AiMP0Ye8bck2otZSJtq1RVptWvE%3D'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}

  */



}









class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});



}
