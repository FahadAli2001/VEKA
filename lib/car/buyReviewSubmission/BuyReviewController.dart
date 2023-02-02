import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:woocommerce_api/woocommerce_api.dart';
class BuyReviewController extends GetxController{



  Future postProduct(carid,price) async {
    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "total": price,
      "customer_id": 0,
      "order_key": "wc_order_SlqkcrTGAPyiF",
      "billing": {
        "first_name": "fahad ali",
        "last_name": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": "",
        "email": "fahad@gmail.com",
        "phone": ""
      },
      "shipping": {
        "first_name": "fahad",
        "last_name": "ali",
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": "",
        "phone": ""
      }
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
       print(response);
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