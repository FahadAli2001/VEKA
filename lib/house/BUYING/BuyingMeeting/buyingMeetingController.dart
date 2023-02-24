import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../login/LoginController.dart';
import '../MeetingSuccess/meetingSuccessScreen.dart';

class buyingMeetingController extends GetxController{

  loginController lc = Get.put(loginController());
  var meetingdate = DateTime.now().obs;
  var meetingtime = DateTime.now().obs;

  Future requestForBuyHouse(houseid) async {
    SharedPreferences homesignup =await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "date_created": meetingtime.value.toString(),
      "date_modified": meetingdate.value.toString(),
      "billing": {
        "first_name": lc.name.toString(),//homesignup.getString("username")
        "last_name":"",
        "address_1": "karachi",
        "address_2": "karachi",
        "city": "karachi",
        "state": "CA",
        "country": "AE",
        "email":  "test@gmail.com",//homesignup.getString("email")
        "phone": "123456789"
      },
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "line_items": [
        {
          "product_id": houseid,
          "quantity": "1"
        }
      ]
    };
    //print("called");
    try{
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: "ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8",
          consumerSecret: "cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37");

      // Post data using the "products" endpoint
      var response = await wooCommerceAPI.postAsync("orders",data);

      //print(meetingdate.value.toString());
     // print(response);
      Get.to(meetingSuccessScreen());


    }catch(e){
      print("erorrrrrrrrrrrrrrrrrrrrr${e.toString()}");
    }

  }
}