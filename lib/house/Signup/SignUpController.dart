import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class HouseSignUpController extends GetxController{

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
      print("vvvvv");
      print(username);
      print(password);
      print(email);
      SignUp();
      Value.value = false;

    }
  }

  void SignUp()async{
    String _username = username.text.toString();
    String _email = email.text.toString();
    String _password = password.text.toString();
    String _conpassword = confirmpassword.text.toString();

    try{
      var response =await http.post(
          Uri.parse("https://vekarealestate.technopreneurssoftware.com/wp-json/wp/v2/users"),
          headers: {
            'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Zla2FyZWFsZXN0YXRlLnRlY2hub3ByZW5ldXJzc29mdHdhcmUuY29tIiwiaWF0IjoxNjc1MTU2OTcxLCJuYmYiOjE2NzUxNTY5NzEsImV4cCI6MTY3NTc2MTc3MSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoxLCJkZXZpY2UiOiIiLCJwYXNzIjoiY2IwMzRhNjc3YTEwYjEyY2NjZjJlNDExMDNiNGM5ZjgifX19.EUnqdbnzA1IPmqi14GF-YE4taKRqfgsmtsZVvNtamr4',
          },
          body: {
            "username":_username,
            "email":_email,
            "password":_password
          }
      );

      if(response.statusCode==201){
        print("method called");
        var data = jsonDecode(response.body.toString());
        //print(data);
        clearFileds();
        print("user created");
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