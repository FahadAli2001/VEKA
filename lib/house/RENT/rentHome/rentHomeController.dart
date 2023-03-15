import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../../../car/Token/AccessToken.dart';

class rentHomeController extends GetxController {

  AcessToken acessToken = Get.put(AcessToken());
  var rentproducts;

  Future rentProduct() async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: acessToken.HouseCK,
          consumerSecret: acessToken.HouseCS);
      rentproducts = await wooCommerceAPI.getAsync(
          "products?type=ovacrs_car_rental"); //?type=ovacrs_car_rental
      //print(rentproducts);

    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      print(e);
    }
    return rentproducts;
  }
}
