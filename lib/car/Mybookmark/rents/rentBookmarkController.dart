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
  var BookmarkId = [].obs;
  var wishListId = {}.obs;
  var pid;
  var data;
  List<Map<String, dynamic>> products = [];
  void onInit() {
    // Initialization logic goes here
    super.onInit();
    //getSharekey();
    // getBookmarksData();
    //getSharekey();
    // getsharekeybyId(pid);
    //getBookmarksData();
  }

  getsharekeybyId(bool isBuy, {String? pid, bool? isWishlist}) async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    var id =
        sigin.getString("userId"); //isko logout krte waqt clear bhi karana hai
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
      String sharekey = data[0]["share_key"];
      if (pid != null) {
        if (isWishlist != null) {
          return await getBookmark(sharekey);
        } else {
          addBookmark(int.parse(pid), sharekey);
        }
      } else {
        final products = await getBookmarksData(sharekey, isBuy);
        return products;
      }
    } else {}
  }

  addBookmark(int pid, String shareKey) async {
    final url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$shareKey/add_product";

    var body = jsonEncode({"product_id": pid, "variation_id": 0, "meta": {}});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
          'wc-authentication':
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
        body: body,
      );

      if (response.statusCode == 200) {
      
        final List<dynamic> wishlistItems = jsonDecode(response.body);

        for (final item in wishlistItems) {
          final productId = item["product_id"] as int;
          final wishlistId = item["item_id"] as int;
          wishListId.putIfAbsent("itemId", () => wishlistId);
          wishListId.putIfAbsent("productId", () => productId);
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

  getBookmarksData(String shareKey, bool isBuy) async {
    try {
      final url =
          "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$shareKey/get_products";
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
        BookmarkId.clear();

        for (final product in data) {
          final productId = product["product_id"] as int;
          final wishlistId = product["item_id"] as int;
          wishListId.putIfAbsent("itemId", () => wishlistId);
          wishListId.putIfAbsent("productId", () => productId);
          BookmarkId.add(productId);
        }

        products = await allBookmark();

        return products;
      } else {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("bookmarks get api ${response.statusCode}");
      }
    } catch (e) {
      print("getbookmark data error : ${e}");
    }
  }

  getBookmark(String sharekey) async {
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
        BookmarkId.clear();

        for (final product in data) {
          final productId = product["product_id"] as int;
          final wishlistId = product["item_id"] as int;
          wishListId.putIfAbsent("itemId", () => wishlistId);
          wishListId.putIfAbsent("productId", () => productId);
          BookmarkId.add(productId);
        }
        return BookmarkId;
      }
    } catch (e) {
      return e;
    }
  }

  allBookmark({bool? isBuy}) async {
    final String include = BookmarkId.join(',');
    final String apiUrl =
        'https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products?include=$include';

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
      products.clear();
      for (final productJson in productsJson) {
        products.add(productJson as Map<String, dynamic>);
      }

      if (isBuy != null && isBuy == true) {
        products = products
            .where((element) => element['type'] == "ovacrs_car_rental")
            .toList();
      } else if (isBuy == false) {
        products =
            products.where((element) => element['type'] == "simple").toList();
      } else {}

      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  removeBookmark(int bookMarkId) async {
    final url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/wishlist/remove_product/$bookMarkId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6')),
        'wc-authentication':
            'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
      },
    );

    if (response.statusCode == 200) {
      wishListId.removeWhere((key, value) => value == bookMarkId);
      BookmarkId.remove(wishListId["productId"]);
      return "Succesfully removed";
    } else {
      return "Something went wrong";
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
