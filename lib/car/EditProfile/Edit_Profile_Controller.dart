import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

  Future getAcessToken() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessTokenclass.username,
            "password": acessTokenclass.password
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];
        // print(accessToken);
        getUserData(accessToken!);
      }
    } catch (e) {
      print("access token" + e.toString());
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
      }
    } catch (e) {
      print("catch error : $e");
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
      }
    });
    try {
      var response = await http.put(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/customers/$userId"),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: body);
      print("after try");
      if (response.statusCode == 200) {
        //var data = jsonDecode(response.body);
//print(data);
        //print(data.toString());
        print("user updated");
      } else {
        print("error ${response.body}");
      }
    } catch (e) {
      print("catch error post : $e");
    }
  }
}
