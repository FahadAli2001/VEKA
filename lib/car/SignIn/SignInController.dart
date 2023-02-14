import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dashboard/dashboardScreen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInController extends GetxController{
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isHidepass = true.obs;

  var isrem = false.obs;
  void handleRadioValueChanged(val) {
    isrem.value = val;
    // print(isrem.value);
  }
  void SignIn()async{
    String _username = username.text.trim().toString();
    String _password = password.text.trim().toString();

    try{
      var response =await http.post(
          Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username":_username,
            "password":_password
          }
      );

      if(response.statusCode==200) {
       //

        //print("method called");
        //print("login");
        var data = jsonDecode(response.body);
        if (isrem.value == true) {
          //print("login");
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString("username", _username);
          sp.setString("password", _password);
          //print(sp.getString("username" ));

        }
        else{
          Get.off(DashboardScreen());
        }
      }else if (response.statusCode == 403){
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "invalid_username") {
          Get.snackbar("Error", "The username is incorrect.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else {
          Get.snackbar("Error", "Wrong password entered",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }
      }
      else{
        Get.to(DashboardScreen());
      }
    }catch(e){
      print(e.toString()+"error");
      Get.snackbar(e.toString(),"SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }
  }

  void signInWithFacebook ()async{
    try{

      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        var cd_accessToken = loginResult.accessToken;
        final userInfo = await FacebookAuth.instance.getUserData();
        //_userData = userInfo;
      }

   /*   final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);*/
    }catch (e){
      print("error"+e.toString());
    }

  }
}