import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class rentHomeController extends GetxController{

  var rentproducts;

  Future rentProduct()async
  {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: "ck_af3ea7f372c93ef5ccf3ef4e46c3ab02d2bd0be8",
          consumerSecret: "cs_8f66eac90fe06004ec4e4e5d240b5b5e2679ab37");
      rentproducts= await wooCommerceAPI.getAsync("products?type=ovacrs_car_rental");//?type=ovacrs_car_rental
      //print(rentproducts);

    }
    catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey

      );
      print(e);
    }
    return rentproducts;
  }


}