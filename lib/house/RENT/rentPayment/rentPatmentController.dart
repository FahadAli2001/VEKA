import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class rentPaymentController extends GetxController{

  var checkIndate = DateTime.now().obs;
  var checkOutdate = DateTime.now().obs;
  var total = 0.obs;

  var adultCount = 1.obs;
  var childrenCount = 1.obs;
  var infantCount = 1.obs;

  void addAdults(){
    adultCount.value++;
  }

  void subAdults(){
    if(adultCount.value <= 0){
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey
      );
    }else{
      adultCount.value--;
    }
  }

  void addChildren(){
    childrenCount.value++;
  }

  void subChildren(){
    if(childrenCount.value <= 0){
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey
      );
    }else{
      childrenCount.value--;
    }
  }

  void addInfant(){
    infantCount.value++;
  }

  void subInfant(){
    if(infantCount.value <= 0){
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey
      );
    }else{
      infantCount.value--;
    }
  }

  int totalhomePrice(List isSelected , List charges, homeprice){
    var difference = checkOutdate.value.difference(checkIndate.value).obs;
    var nofdays =  difference.value.inDays;

    total.value = int.parse(homeprice)  *nofdays ;
   // total.value = total.value * nofdays;
    print(total.value);
    for (var entry in isSelected.asMap().entries) {
      if (entry.value == true) {
        print('Index ${entry.key} has value of true');
        total.value += (int.parse(charges[entry.key]));
      }

    }
    return total.value;
  }

  Future requestForBuyHouse(houseid) async {
    SharedPreferences homesignup =await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "status": "processing",
      "currency": "USD",
      "date_created": checkIndate.value.toString(),
      "date_modified": checkOutdate.value.toString(),
      "billing": {
        "first_name": "",//homesignup.getString("username")
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

     // print(meetingdate.value.toString());
      // print(response);
      //Get.to(meetingSuccessScreen());


    }catch(e){
      print("erorrrrrrrrrrrrrrrrrrrrr${e.toString()}");
    }

  }

}