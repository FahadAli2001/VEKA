import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../Token/AccessToken.dart';

class CarHomePageController extends GetxController {
  var allProduct;
  RxBool isLoad = false.obs; //for checking data is load
  RxBool rent = true.obs;
  RxBool buy = false.obs;
  var userName = "".obs;
  var image = "".obs;
  var rentbtn = Colors.black.obs;
  var renttxt = Colors.white.obs;
  var buybtn = Colors.white.obs;
  var buytxt = Colors.black.obs;
  var rentData;
  String? accessToken;
  AcessToken acessTokenclass = Get.put(AcessToken());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  Future allproducts() async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
      allProduct = await wooCommerceAPI.getAsync("products");
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    }
    return allProduct;
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    isLoad.value = true;
    allProduct = await allproducts();
    isLoad.value = false;
    if (prefs.getString("username") != null) {
      userName.value = prefs.getString("username")!;
      image.value = prefs.getString("image")!;
    } else {
      userName.value = "Guest";
      getAcessToken(userId!);
    }

    userName.value = prefs.getString("username")!;
  }

  Future getAcessToken(String userId) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessTokenclass.AutoMobileusername,
            "password": acessTokenclass.AutoMobilepassword
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
    print(userId);
    try {
      final response = await http.get(
        Uri.parse(
            "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //print(data.toString());
        userName.value = data["username"];
        image.value = data["meta_data"][1]['value'];
        prefs.setString("username", userName.value);
        prefs.setString("image", image.value);
        // userLastName = data["billing"]["last_name"];
        // userAddress = data["billing"]["address_1"];
        // userCountry = data["billing"]["country"];
        // userCity = data["billing"]["city"];
        // userContact = data["billing"]["phone"];
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

  Future rentProduct() async {
    {
      try {
        WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
            url: "https://vekaautomobile.technopreneurssoftware.com",
            consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
            consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
        rentData = await wooCommerceAPI
            .getAsync("products?type=ovacrs_car_rental"); //  simple
        // print(rentData);
      } catch (e) {
        print(e);
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      }
      return rentData;
    }
  }

  var selldata;
  Future sellProduct() async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
      selldata = await wooCommerceAPI.getAsync("products?type=simple");
    } catch (e) {
      print("sell api : ${e.toString()}");
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    }
    return selldata;
  }

  var parsedstring;
  HtmlToText(val) {
    var description = parse(val);
    parsedstring = description.documentElement!.text;

    return parsedstring;
  }
}
