import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BUYING/home/homeScreen.dart';

class loginController extends GetxController {
  var userId;
  var name;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isHidepass = true.obs;

  var isremember = false.obs;
  void handleRadioValueChanged(val) {
    isremember.value = val;
  }

  var data;
  GetUsername() async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    userRef.get().then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        name = data!['name'];
        print('User name: $name');
      } else {
        print('User not found in database.');
      }
    }).catchError((error) {
      print('Error getting user data: $error');
    });
  }

  void SignIn() async {
    String _username = username.text.trim().toString();
    String _password = password.text.trim().toString();

    try {
      var response = await http.post(
          Uri.parse(
              "https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {"username": _username, "password": _password});

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        if (isremember.value == true) {
          SharedPreferences homesignin = await SharedPreferences.getInstance();
          homesignin.setString("email", _username);
          print(homesignin.getString("email"));
          Get.off(homeScreen());
        } else {
          Get.off(homeScreen());
        }
      } else if (response.statusCode == 403) {
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "invalid_email") {
          Get.snackbar("Error", "The email is incorrect.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "incorrect_password") {
          Get.snackbar("Error", "Wrong password entered",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "incorrect_password" &&
            errorCode == "invalid_email") {
          Get.snackbar("Error", "Wrong email and Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else {
          print(response.statusCode);
          /* Get.snackbar("Error", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);*/
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Some error occurred, please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }
  }

  void SignInWithFirebase() async {
    String _email = username.text.trim().toString();
    String _password = password.text.trim().toString();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      userId = FirebaseAuth.instance.currentUser!.uid;
      GetUsername();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }
  }

  void forgetpassword() async {
    try {
      final Uri _url = Uri.parse(
          'https://vekarealestate.technopreneurssoftware.com/my-account/lost-password');

      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        await launchUrl(_url);
        //print('Could not launch $_url');
      }
    } catch (e) {
      print("eroorr" + e.toString());
    }
  }
}
