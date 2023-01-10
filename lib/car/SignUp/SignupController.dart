import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Dashboard/dashboardScreen.dart';

class SignUpController extends GetxController{

  var Value = false.obs;
  void handleRadioValueChanged(val) {
    Value.value = val;
  }

  void checkIsAgree (){
    if(Value.value == false){
      Get.defaultDialog(
        buttonColor: Colors.green,
        title: "",
        middleText: "Please agree with our terms and condition",
        textConfirm: "Ok",
        onConfirm: (){
          Get.back();

        }
      );
    }else{
      Get.to(DashboardScreen());
      Value.value = false;
    }
  }
}