import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Token/AccessToken.dart';

class EditProfileController extends GetxController {
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
  bool getUserdata = false;

  Future getAcessToken({File? image}) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessTokenclass.AutoMobileusername,
            "password": acessTokenclass.AutoMobilepassword
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];
        // print(accessToken);
        if (image == null) {
          getUserData(accessToken!);
        } else {
          UploadImage(image, accessToken!);
        }
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
    SharedPreferences sigin = await SharedPreferences.getInstance();
    String? userId = sigin.getString("userId");
    print(userId);
    try {
      final response = await http.get(
        Uri.parse(
            "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
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

  Future updateProfile(String imageUrl, String accessToken) async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    String? userId = sigin.getString("userId");
    print(userId);
    print(imageUrl);
    var body = json.encode({
      "meta_data": [
        {"key": "my_url", "value": imageUrl}
      ]
    });
    var response = await http.put(
        Uri.parse(
            "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
        headers: {'Authorization': 'Bearer $accessToken', 'Cookie': 'tinvwl_wishlists_data_counter=0'},
        body: body);

    if (response.statusCode == 200) {

      print("user updated");
      print(response.statusCode);
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
  }

  Future UpdateUserData(String accessToken) async {
    String _firstName = firstName.toString();
    String _lastName = lastName.toString();
    String _country = country.toString();
    String _city = city.toString();
    String _contact = contact.toString();
    String _address = address.text.toString();
    SharedPreferences sigin = await SharedPreferences.getInstance();
    String? userId = sigin.getString("userId");
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
      },
    });
    try {
      var response = await http.put(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: body);
      print("after try");
      if (response.statusCode == 200) {
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

  // ignore: non_constant_identifier_names
  Future UploadImage(File image, String accessToken) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/media'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String byte = await response.stream.bytesToString();
      var temp = jsonDecode(byte);
      String profilePicUrl = temp['guid']['raw'];
      updateProfile(profilePicUrl, accessToken);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }
}
