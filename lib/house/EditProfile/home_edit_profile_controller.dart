import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../car/Token/AccessToken.dart';

class HomeEditProfileController extends GetxController {
  AcessToken acessTokenclass = Get.put(AcessToken());

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController contact = TextEditingController();

  String? accessToken;

  String? userFirstName;
  String? userLastName;
  String? userAddress;
  String? userCountry;
  String? userCity;
  String? userContact;

  Future getAcessToken() async {
    print("getaccess token");
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessTokenclass.RealStateusername,
            "password": acessTokenclass.RealStatepassword
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];
        // print(accessToken);
        getUserData(accessToken!);
      } else {
        print("acess token ${response.statusCode}");
        print(response.body.toString());
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
    return accessToken;
  }

  Future getUserData(String accessToken) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();
    String? userId = homesignin.getInt("realStateUserId").toString();
    print(userId);
    try {
      final response = await http.get(
        Uri.parse(
            "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        //print(data.toString());
        userFirstName = data["billing"]["first_name"];
        userLastName = data["billing"]["last_name"];
        userAddress = data["billing"]["address_1"];
        userCountry = data["billing"]["country"];
        userCity = data["billing"]["city"];
        userContact = data["billing"]["phone"];
        UpdateUserData(accessToken);
      } else {
        print("error ${response.statusCode}");
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.black);
      }
    } catch (e) {
      print("catch error : $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
  }

  Future UpdateUserData(String accessToken) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();
    String? userId = homesignin.getInt("realStateUserId").toString();
    String _firstName = firstName.toString();
    String _lastName = lastName.toString();
    String _country = country.toString();
    String _city = city.toString();
    String _contact = contact.toString();
    String _address = address.text.toString();

    var body = json.encode({
      "first_name": _firstName,
      "last_name": _lastName,
      "billing": {
        "first_name": "",
        "last_name": "",
        "company": "",
        "address_1": _country,
        "address_2": "",
        "city": _city,
        "postcode": "",
        "country": "",
        "state": "",
        "email": "",
        "phone": _contact
      }
    });
    try {
      var response = await http.put(
          Uri.parse(
              "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: body);
      print("after try");
      if (response.statusCode == 200) {
        //var data = jsonDecode(response.body);
//print(data);
        //print(data.toString());
        ClearTextField();
        print("user updated");
        Get.snackbar("Success Message ", "User updated successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.black);
      } else {
        print("error ${response.body}");
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.black);
      }
    } catch (e) {
      print("catch error post : $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
  }

  ClearTextField() {
    firstName.clear();
    lastName.clear();
    address.clear();
    city.clear();
    country.clear();
    contact.clear();
  }
}
