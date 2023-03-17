import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/house/BUYING/home/homeScreen.dart';
import 'package:veka/house/RENT/dashboard/dashboard.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../SignIn/SignInController.dart';
import '../SignUp/SignupController.dart';
import '../Token/AccessToken.dart';

class BuyReviewController extends GetxController {
  SignInController sic = Get.put(SignInController());

  AcessToken acessToken = Get.put(AcessToken());

  //carid
  //signupshared.getString("username")
  //signupshared.getString("email")

  Future postProduct(carid, price) async {
    SharedPreferences sigin = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "billing": {
        "first_name": sigin.getString("name"),
        "last_name": "",
        "address_1": "karachi",
        "address_2": "karachi",
        "city": "karachi",
        "state": "CA",
        "country": "AE",
        "email": sigin.getString("email"),
        "phone": "123456789"
      },
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "line_items": [
        {"product_id": carid, "quantity": "1"}
      ]
    };
    //print("called");
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: acessToken.CarCK,
          consumerSecret: acessToken.CarCS);

      // Post data using the "products" endpoint
      var response = await wooCommerceAPI.postAsync("orders", data);

      // print("called");
      // print(carid);

      // print(response);
      Get.defaultDialog(
          buttonColor: Colors.green,
          title: "",
          //DashboardScreen()
          middleText:
              "Your booking has been successfully completed ",
          onConfirm: () {
            Get.offAll(const dashboard());
            //Get.to(DashboardScreen());
          });
    } catch (e) {
      print("erorr${e.toString()}");
    }
  }
}
