import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class rentPaymentController extends GetxController{

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

}