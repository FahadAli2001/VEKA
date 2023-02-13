import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class HouseSignUpController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  var accessToken;

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
  //https://vekarealestate.technopreneurssoftware.com/wp-json/wp/v2/users
  void SignUp()async{
    SharedPreferences homesignup =await SharedPreferences.getInstance();
    String _username = username.text.toString();
    String _email = email.text.toString();
    String _password = password.text.toString();
    String _conpassword = confirmpassword.text.toString();

    try{
      getAcessToken();
      //print(accessToken);
      var response =await http.post(
          Uri.parse("https://vekarealestate.technopreneurssoftware.com/wp-json/wp/v2/users"),
          headers: {
            'Authorization':
            'Bearer $accessToken',
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
        homesignup.setString("username", _username);
        homesignup.setString("email", _email);
        //print(data);
        clearFileds();
        print("user created");
        Get.snackbar("","User Created Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black);
      }else {
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "existing_user_login") {
          Get.snackbar("Error", "Sorry, that username already exists!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }else if (errorCode == "existing_user_email"){
          Get.snackbar("Error", "Sorry, that email address is already used!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }
      }
    }catch(e){
      print(e.toString()+"errorrrrrrrrrrrrrrrrrrrrrrrr");
      Get.snackbar("Error","SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);//print(_email);
    }

  }
  Future getAcessToken ()async{
    try{
      var response =await http.post(
          Uri.parse("https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username":"cveru",
            "password":"I&Ljfv2MfW:wc"
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];

      }
    }catch (e){
      print("access token" + e.toString());
    }
    return accessToken;
  }


  void clearFileds(){
    username.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
  }


}