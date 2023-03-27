import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../car/Token/AccessToken.dart';
import '../BUYING/houseHome/sellHomeController.dart';

class HomeEditProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAcessToken();
  }

  AcessToken acessTokenclass = Get.put(AcessToken());

  sellHomeController sellController = Get.put(sellHomeController());

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController contact = TextEditingController();

  String? accessToken;
  var image = "".obs;
  RxBool isLoad = false.obs; //for checking data is load
  var userName = "".obs;

  var allProduct;
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
        log(data.toString());
        firstName.text = data["first_name"];
        lastName.text = data["last_name"];
        address.text = data["billing"]["address_1"];
        country.text = data["billing"]["country"];
        city.text = data["billing"]["city"];
        contact.text = data["billing"]["phone"];
        image.value = data["meta_data"][1]["value"];
        print(data["billing"]["first_name"]);
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
    String? email = homesignin.getString("Email");
    String _firstName = firstName.text;
    String _lastName = lastName.text;
    String _country = country.text;
    String _city = city.text;
    String _contact = contact.text;
    String _address = address.text;

    var body = json.encode({
      "first_name": _firstName,
      "last_name": _lastName,
      "billing": {
        "first_name": _firstName,
        "last_name": _lastName,
        "company": "",
        "address_1": _country,
        "address_2": "",
        "city": _city,
        "postcode": "",
        "country": "",
        "state": "",
        "email": email.toString(),
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
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${acessTokenclass.HouseCK}:${acessTokenclass.HouseCS}'))}',
            'wc-authentication':
                '${acessTokenclass.HouseCK}:${acessTokenclass.HouseCS}',
          },
          body: body);
      print("after try");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("after updated ${data}");
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
