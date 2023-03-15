import 'dart:convert';
import 'dart:developer';

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
  var iconColor = Colors.grey.obs;
  var sharekey;
  var BookmarkId = [];
  var pid;
  var data;
  final List<Map<String, dynamic>> products = [];
  void onInit() {
    // Initialization logic goes here
    super.onInit();
    //getSharekey();
    // getBookmarksData();
    //getSharekey();
    // getsharekeybyId(pid);
     //getBookmarksData();

  }
  
  getsharekeybyId(pid) async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    var id = sigin.getString("userId");//isko logout krte waqt clear bhi karana hai
    print("user id : ${id}");
    final url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/$id";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication':
            'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      sharekey = data[0]["share_key"];
      print(sharekey);
      // print(data.toString());
      addBookmark(pid);
    } else {
      print("get api ${response.statusCode}");
      print(response.body);
    }
    print("sharekey : ${sharekey}");
  }

  addBookmark(pid) async {
    print("sharekey ${sharekey}");
    final url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$sharekey/add_product";
    print(url);
    print(pid);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
          'wc-authentication':
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
        body: jsonEncode({"product_id": pid, "variation_id": 0, "meta": {}}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> wishlistItems = jsonDecode(response.body);
        final List<int> productIds = [];
        for (final item in wishlistItems) {
          BookmarkId.add(item['product_id']);
        }
        return BookmarkId;
      } else {
        throw Exception('Failed to fetch product IDs');
      }
    } catch (e) {
      print("something went wrong");
    }
  }

  getBookmarksData() async {
    getsharekeybyId(pid);
    print(sharekey);
    try {
      final url =
          "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$sharekey/get_products";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
          'wc-authentication':
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        for (final product in data) {
          final productId = product["product_id"] as int;
          BookmarkId.add(productId);
        }

        //final products = await fetchProducts();
        //return products;

      } else {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("bookmarks get api ${response.statusCode}");
      }
    } catch (e) {
      print("getbookmark data error : ${e}");
    }
  }

  allBookmark() async {
    final String include = BookmarkId.join(',');
    final String apiUrl = 'https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products?include=$include';

    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
      'wc-authentication':
      'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
    });

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = jsonDecode(response.body);

      for (final productJson in productsJson) {
        products.add(productJson as Map<String, dynamic>);

      }
     // print(products.toString());
      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }


}

class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});
}
