import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboardScreen.dart';
import '../bookingScreen/bookingScreenController.dart';
class RentReviewSubmissionController extends GetxController{
  bookingScreenController bsc = Get.put(bookingScreenController());


  void postRentOrder(carid,isSelected)async{
    SharedPreferences signupshared =await SharedPreferences.getInstance();
    Map<String, dynamic> data =  {
      "status": "processing",
      "billing": {
        "first_name": signupshared.getString("username"),
        "last_name": "",
        "company": "23",
        "address_1": "123",
        "address_2": "123",
        "city": "123",
        "state": "SD",
        "postcode": "76550",
        "country": "PK",
        "email": signupshared.getString("email"),
        "phone": "74643"
      },
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "created_via": "rest-api",
      "line_items": [
        {
          "product_id": carid,
          "quantity": bsc.carqntyvalue.value.toString(),
          "total": bsc.total.value.toString(),
          "meta_data": [
            {
              "key": "ovacrs_pickup_date",
              "value": bsc.pickupdate.value.toString(),
              "display_key": "Pick-up date"
            },
            {
              "key": "ovacrs_pickoff_date",
              "value":bsc.dropOfdate.value.toString(),
              "display_key": "Drop-off date"
            },
            {
              "key": "ovacrs_total_days",
              "value": ""

            },
            {
              "key": "ovacrs_price_detail",
              "value": ""
            },
            {
              "key": "Baby_Seat",
              "value": isSelected[0]
            },
            {
              "key": "Car_Seat_For_Childres",
              "value": isSelected[1]
            },
            {
              "key": "Navigation",
              "value": isSelected[2]
            },
            {
              "key": "Additional_Driver",
              "value": isSelected[3]
            },
            {
              "key": "Ful_Rent_a_Car_Insures",
              "value":isSelected[4]
            },
            {
              "key": "Unlimited Kilometres",
              "value":isSelected[5]
            },
            {
              "key": "rental_type",
              "value": "day"
            },
            {
              "key": "ovacrs_deposit_amount_product",
              "value": ""

            },
            {
              "key": "ovacrs_remaining_amount_product",
              "value": "0"

            },
            {
              "key": "id_vehicle",
              "value": ""

            },
            {
              "key": "ovacrs_quantity",
              "value": "1"

            }
          ]       }   ],
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title": "Flat Rate",
          "total": ""
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
            middleText: "Your booking has been successfully completed}",
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