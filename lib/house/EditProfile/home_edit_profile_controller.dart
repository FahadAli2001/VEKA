import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  var image = "".obs;
  Future getAcessToken({File? image}) async {
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
        if (image == null) {
          getUserData(accessToken!);
        } else {
          UploadImage(image, accessToken!);
        }
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
        firstName.text = data["billing"]["first_name"];
        lastName.text = data["billing"]["last_name"];
        address.text = data["billing"]["address_1"];
        country.text = data["billing"]["country"];
        city.text = data["billing"]["city"];
        contact.text = data["billing"]["phone"];
        image.value = data["meta_data"][1]["value"];
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

  Future UpdateUserData(String accessToken, String profilePicture) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();
    String? userId = homesignin.getInt("realStateUserId").toString();
    String? email = homesignin.getString("email");
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
        "email": email,
        "phone": _contact
      },
      "meta_data": [
        {"key": "my_url", "value": profilePicture}
      ]
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

  Future UploadImage(File image, String accessToken) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://vekarealestate.technopreneurssoftware.com/wp-json/wp/v2/media'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String byte = await response.stream.bytesToString();
      var temp = jsonDecode(byte);
      String profilePicUrl = temp['guid']['raw'];

      UpdateUserData(accessToken, profilePicUrl);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  Future updateProfile(String imageUrl, String accessToken) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();
    String? userId = homesignin.getInt("realStateUserId").toString();

    print(userId);
    print(imageUrl);

    var body = json.encode({
      "meta_data": [
        {"key": "my_url", "value": imageUrl}
      ]
    });
    print(body);
    var response = await http.patch(
        Uri.parse(
            "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: body);

    if (response.statusCode == 200) {
      print("user updated");
      print(response.statusCode);
      print(response.body);

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
}
