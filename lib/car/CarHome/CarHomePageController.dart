import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class CarHomePageController extends GetxController{
  var allProduct;
  RxBool isLoad = false.obs;//for checking data is load
  RxBool rent = true.obs;
  RxBool buy = false.obs;
  var rentbtn =Colors.black.obs;
  var renttxt = Colors.white.obs;
  var buybtn =Colors.white.obs;
  var buytxt = Colors.black.obs;
  var rentData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  Future allproducts()async
  {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
      allProduct = await wooCommerceAPI.getAsync("products");


    }
    catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey
      );
    }
    return allProduct;
  }

  getData()async{
    isLoad.value = true;
    allProduct = await allproducts();
    isLoad.value = false;
  }


  Future rentProduct()async{
    {
      try {
        WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
            url: "https://vekaautomobile.technopreneurssoftware.com",
            consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
            consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
        rentData = await wooCommerceAPI.getAsync("products?type=ovacrs_car_rental");//  simple
        // print(rentData);


      }
      catch(e){
        print(e);
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey
        );
      }
      return rentData;
    }
  }
  var selldata;
  Future sellProduct()async{
    try{
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekaautomobile.technopreneurssoftware.com",
          consumerKey: "ck_35efc60387133919ea7a6e22c34a2201af711f47",
          consumerSecret: "cs_650113cb966d76d8f9f926b41f9a894186e2dcd6");
      selldata = await wooCommerceAPI.getAsync("products?type=simple");
    }catch(e){
      print("sell api : ${e.toString()}");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey);
    }
    return selldata;
  }

}