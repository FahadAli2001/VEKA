import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboardScreen.dart';

class SignUpController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  RxBool isHidepass = true.obs;
  var isHideconpass = true.obs;

  var Value = false.obs;
  void handleRadioValueChanged(val) {
    Value.value = val;
  }

  void checkIsAgree (){
    if(Value.value == false){
      Get.defaultDialog(
        buttonColor: Colors.black,
        title: "",
        middleText: "Please agree with our terms and condition",
        textConfirm: "Ok",
        onConfirm: (){
          Get.back();

        }
      );
    }else{
      SignUp();
      Value.value = false;

    }
  }

  void SignUp()async{
    SharedPreferences signupshared =await SharedPreferences.getInstance();
    String _username = username.text.toString();
    String _email = email.text.toString();
    String _password = password.text.toString();
    String _conpassword = confirmpassword.text.toString();

    try{

      var response =await http.post(
          Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/users"),
          headers: {
            'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Zla2FhdXRvbW9iaWxlLnRlY2hub3ByZW5ldXJzc29mdHdhcmUuY29tIiwiaWF0IjoxNjc1MTUzNDU1LCJuYmYiOjE2NzUxNTM0NTUsImV4cCI6MTY3NTc1ODI1NSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoxLCJkZXZpY2UiOiIiLCJwYXNzIjoiOTI1OGYyNDI4NzQ3ODFkMTMyM2JjYTQxODA5YzI3YjYifX19.HCM5ZPH-eOqwKJEjtFLeuN3HFpoeeTHKXdKL_dZwgrE',
          },
          body: {
            "username":_username,
            "email":_email,
            "password":_password
          }
      );
      print("method called");
      if(response.statusCode==201){

        var data = jsonDecode(response.body.toString());
        signupshared.setString("username", _username);
        signupshared.setString("email", _email);
       // print(data);
        clearFileds();
       // print("user created");
        Get.snackbar("","User Created Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black);//print(_email);
      }
    }catch(e){
      print(e.toString()+"errorrrrrrrrrrrrrrrrrrrrrrrr");
      Get.snackbar("","SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);//print(_email);
    }

  }


  void clearFileds(){
    username.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
  }


}