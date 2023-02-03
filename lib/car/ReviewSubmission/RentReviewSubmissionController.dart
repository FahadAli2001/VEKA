import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboardScreen.dart';
import '../bookingScreen/bookingScreenController.dart';
class RentReviewSubmissionController extends GetxController{
  bookingScreenController bsc = Get.put(bookingScreenController());
  void postRentOrder(carid)async{
    SharedPreferences signupshared =await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "billing": {
        "first_name": signupshared.getString("username"),
        "last_name":"",
        "address_1": bsc.pick.value.toString(),
        "address_2": bsc.drop.value.toString(),
        "date_created": bsc.pickupdate.value.toString(),
        "date_modified": bsc.dropOfdate.value.toString(),
        "total": bsc.total.value.toString(),
        "city": "karachi",
        "state": "CA",
        "country": "AE",
        "email":  signupshared.getString("email"),
        "phone": "123456789"
      },
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "line_items": [
        {
          "product_id": carid,
          "quantity": bsc.carqntyvalue.value.toString()
        }
      ]
    };
    try{
      final response = await http.get(
        Uri.parse("https://vekaautomobile.technopreneurssoftware.com"),
        headers: {
          'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
          'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
        },
      );
      if(response.statusCode == 200){
        Get.defaultDialog(
            buttonColor: Colors.green,
            title: "",
            //DashboardScreen()
            middleText: "Your booking has been successfully completed ${bsc.total.toString()}",
            onConfirm: (){
              Get.back();
             // Get.to(DashboardScreen());
              //Get.to(DashboardScreen());
            }
        );
        print("order submited");
      }
    }catch(e){
      print(e.toString());
    }
  }
}