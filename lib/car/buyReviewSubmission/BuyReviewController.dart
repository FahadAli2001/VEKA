import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../SignIn/SignInController.dart';
import '../SignUp/SignupController.dart';
class BuyReviewController extends GetxController{
  SignInController sic = Get.put(SignInController());

  //carid
  //signupshared.getString("username")
  //signupshared.getString("email")


  Future postProduct(carid,price) async {
    SharedPreferences signupshared =await SharedPreferences.getInstance();

    Map<String, dynamic> data ={
      "status": "processing",
      "currency": "USD",
      "billing": {
        "first_name": sic.name,
        "last_name":"",
        "address_1": "karachi",
        "address_2": "karachi",
        "city": "karachi",
        "state": "CA",
        "country": "AE",
        "email":  signupshared.getString("username"),
        "phone": "123456789"
      },
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "line_items": [
        {
          "product_id": carid,
          "quantity": "1"
        }
      ]
    };
    //print("called");
    try{
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");

      // Post data using the "products" endpoint
      var response = await wooCommerceAPI.postAsync("orders",data);

     // print("called");
     // print(carid);

      // print(response);
        Get.defaultDialog(
            buttonColor: Colors.green,
            title: "",
            //DashboardScreen()
            middleText: "Your booking has been successfully completed",
            onConfirm: (){
              Get.back();
              //Get.to(DashboardScreen());
            }
        );


    }catch(e){
      print("erorrrrrrrrrrrrrrrrrrrrr${e.toString()}");
    }

  }
}