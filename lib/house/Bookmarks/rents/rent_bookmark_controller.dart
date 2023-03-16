import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class RealStateRentBookmarkController extends GetxController {
  // SignInController sic = Get.put(SignInController());

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
    //getSharekey();
    // getBookmarksData();
    //getSharekey();
    // getsharekeybyId(pid);
    //getBookmarksData();
  }

  getsharekeybyId(bool isBuy, {String? pid, bool? isWishlist}) async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    var id = sigin.getInt("realStateUserId");
    print("user id : $id");
    final url =
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/wishlist/get_by_user/$id";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
        'wc-authentication':
            'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      String sharekey = data[0]["share_key"];

      if (pid != null) {
        if (isWishlist != null) {
          print("working");
          return await getBookmark(sharekey);
        } else {
          print("addBookmarks $sharekey $pid");
          addBookmark(int.parse(pid), sharekey);
        }
      } else {
        
        final products = await getBookmarksData(sharekey, isBuy);

        return products;
      }
    } else {}
  }

  addBookmark(int pid, String shareKey) async {
    print("addBookmark $shareKey $pid");
    final url =
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$shareKey/add_product";

    var body = jsonEncode({"product_id": pid, "variation_id": 0, "meta": {}});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
          'wc-authentication':
              'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        print("Add Bookmarks");
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
      log("something went wrong");
    }
  }

  getBookmarksData(String shareKey, bool isBuy) async {
    try {
      final url =
          "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$shareKey/get_products";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
          'wc-authentication':
              'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("data");
        BookmarkId.clear();

        for (final product in data) {
          final productId = product["product_id"] as int;
          final wishlistId = product["item_id"] as int;
          wishListId.putIfAbsent("itemId", () => wishlistId);
          wishListId.putIfAbsent("productId", () => productId);
          BookmarkId.add(productId);
        }

        products = await allBookmark(isBuy: isBuy);

        return products;
      } else {
        log("bookmarks get api ${response.statusCode}");
      }
    } catch (e) {
      log("getbookmark data error : $e");
    }
  }

  getBookmark(String sharekey) async {
    print(sharekey);
    try {
      final url =
          "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/wishlist/$sharekey/get_products";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
          'wc-authentication':
              'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("data");
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
    final String include = BookmarkId.isNotEmpty ? BookmarkId.join(',') : "0";
    final String apiUrl =
        'https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/products?include=$include';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
        'wc-authentication':
            'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
      },
    );

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
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/wishlist/remove_product/$bookMarkId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
      
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37')),
        'wc-authentication':
            'ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8:cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37',
      },
    );

    if (response.statusCode == 200) {
      wishListId.removeWhere((key, value) => value == bookMarkId);
      products.removeWhere((element) => element["id"] == bookMarkId);
      BookmarkId.remove(wishListId["productId"]);
      return "Succesfully removed";
    } else {
      return "Something went wrong";
    }
  }
}
