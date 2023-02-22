import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboardScreen.dart';
import '../Token/AccessToken.dart';

class SignUpController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  AcessToken acessTokenclass = Get.put(AcessToken());

  RxBool isHidepass = true.obs;
  var isHideconpass = true.obs;

  var accessToken;

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
      getAcessToken();
      //print(accessToken);
      var response = await http.post(
          Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/users"),
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
      print("method called");
      if(response.statusCode==201){
        SignUpWithFirebase();
        var data = jsonDecode(response.body.toString());
        signupshared.setString("username", _username);
        signupshared.setString("email", _email);
        print("user created");
        Get.snackbar("","User Created Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black);//print(_email);
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
    }catch (e){
      print(e.toString()+"errorr");
      Get.snackbar("","SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);//print(_email);
    }

  }
  Future getAcessToken ()async{
    try{
      var response =await http.post(
          Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username":acessTokenclass.username,
            "password":acessTokenclass.password
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

  SignUpWithFirebase()async{
    String _email = email.text.toString();
    String _password = password.text.toString();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if(credential != null){
        clearFileds();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("","SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    } catch (e) {
      print(e);
    }

  }


}