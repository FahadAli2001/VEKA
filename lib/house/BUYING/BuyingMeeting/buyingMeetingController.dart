import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../../car/Token/AccessToken.dart';
import '../../login/LoginController.dart';
import '../MeetingSuccess/meetingSuccessScreen.dart';

class buyingMeetingController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());
  loginController lc = Get.put(loginController());
  var meetingdate = DateTime.now().obs;
  var meetingtime = DateTime.now().obs;

  Future requestForBuyHouse(houseid) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "date_created": meetingtime.value.toString(),
      "date_modified": meetingdate.value.toString(),
      "billing": {
        "first_name":
            homesignin.getString("name"), //homesignup.getString("username")
        "last_name": "",
        "address_1": "karachi",
        "address_2": "karachi",
        "city": "karachi",
        "state": "CA",
        "country": "AE",
        "email": homesignin.getString("Email"), //homesignup.getString("email")
        "phone": "123456789"
      },
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "line_items": [
        {"product_id": houseid, "quantity": "1"}
      ]
    };
    //print("called");
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: acessToken.HouseCK,
          consumerSecret: acessToken.HouseCS);

      // Post data using the "products" endpoint
      var response = await wooCommerceAPI.postAsync("orders", data);

      //print(meetingdate.value.toString());
      // print(response);
      Get.to(meetingSuccessScreen());
    } catch (e) {
      print("erorr${e.toString()}");
    }
  }
}
