import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../../car/Token/AccessToken.dart';

class RentBookingDatesController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());

  var dates;
  void getBookedDates() async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: acessToken.HouseCK,
          consumerSecret: acessToken.HouseCS);
      dates = await wooCommerceAPI.getAsync("orders"); //?type=ovacrs_car_rental
      print(dates[0]["line_items"]["0"]["meta_data"][0]["display_value"]
          .toString()); //
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      print(e);
    }
  }
}
