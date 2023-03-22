import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;
import '../../../car/Token/AccessToken.dart';
import '../../BUYING/home/homeScreen.dart';
import '../../login/LoginController.dart';

class rentPaymentController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());
  loginController lc = Get.put(loginController());

  var checkIndate = DateTime.now().obs;
  var checkOutdate = DateTime.now().obs;
  var total = 0.obs;
  RxList eventDates = [].obs;
  var adultCount = 1.obs;
  var childrenCount = 1.obs;
  var infantCount = 1.obs;
  String? name;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getName();
  }

  Future<String> getOrders() async {
    String url =
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/orders";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('${acessToken.HouseCK}:${acessToken.HouseCS}'))}',
          'wc-authentication': '${acessToken.HouseCK}:${acessToken.HouseCS}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        for (var element in data) {
          if (element['line_items'][0]["meta_data"] != []) {
            DateTime temp = DateTime.parse(
                element["line_items"][0]['meta_data'][0]['value']);
            eventDates.add("${temp.day}:${temp.month}:${temp.year}");
          }
        }
        return "Success";
      } else {}
    } catch (e) {
      return e.toString();
    }
    throw "Something went wrong";
  }

  void getName() async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();
    name = homesignin.getString("name");
  }

  void addAdults() {
    adultCount.value++;
  }

  void subAdults() {
    if (adultCount.value <= 0) {
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    } else {
      adultCount.value--;
    }
  }

  void addChildren() {
    childrenCount.value++;
  }

  void subChildren() {
    if (childrenCount.value <= 0) {
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    } else {
      childrenCount.value--;
    }
  }

  void addInfant() {
    infantCount.value++;
  }

  void subInfant() {
    if (infantCount.value <= 0) {
      Get.snackbar("Error", "In-valid input",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    } else {
      infantCount.value--;
    }
  }

  int totalhomePrice(List isSelected, List charges, homeprice) {
    var difference = checkOutdate.value.difference(checkIndate.value).obs;
    var nofdays = difference.value.inDays + 1;

    total.value = int.parse(homeprice) * nofdays;
    print(nofdays);
    // total.value = total.value * nofdays;
    //print(total.value);
    for (var entry in isSelected.asMap().entries) {
      if (entry.value == true) {
        print('Index ${entry.key} has value of true');
        total.value += (int.parse(charges[entry.key]));
      }
    }
    return total.value;
  }

  Future requestForBuyHouse(houseid, List isSelected) async {
    SharedPreferences homesignin = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "status": "processing",
      "billing": {
        "first_name": homesignin.getString("name"),
        "last_name": "",
        "company": "23",
        "address_1": "123",
        "address_2": "123",
        "city": "123",
        "state": "SD",
        "postcode": "76550",
        "country": "PK",
        "email": homesignin.getString("Email"),
        "phone": "74643"
      },
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "created_via": "rest-api",
      "line_items": [
        {
          "product_id": houseid,
          "quantity": 1,
          "total": total.value.toString(),
          "meta_data": [
            {
              "key": "ovacrs_pickup_date",
              "value": checkIndate.value.toString(),
              "display_key": "Pick-up date"
            },
            {
              "key": "ovacrs_pickoff_date",
              "value": checkOutdate.value.toString(),
              "display_key": "Drop-off date"
            },
            {"key": "ovacrs_total_days", "value": ""},
            {"key": "ovacrs_price_detail", "value": ""},
            {"key": "Snacks", "value": isSelected[0].toString()},
            {"key": "Beverages", "value": isSelected[1].toString()},
            {"key": "rental_type", "value": "day"},
            {"key": "ovacrs_deposit_amount_product", "value": ""},
            {"key": "ovacrs_remaining_amount_product", "value": "0"},
            {"key": "id_vehicle", "value": ""},
            {"key": "ovacrs_quantity", "value": "1"}
          ]
        }
      ],
      "shipping_lines": [
        {"method_id": "flat_rate", "method_title": "Flat Rate", "total": ""}
      ]
    };
    //print("called");
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://vekarealestate.technopreneurssoftware.com",
          consumerKey: acessToken.HouseCK,
          consumerSecret: acessToken.HouseCS);

      // Post data using the "products" endpoint
      var response = await wooCommerceAPI.postAsync("orders", data);
      Get.defaultDialog(
          buttonColor: Colors.green,
          title: "",
          //DashboardScreen()
          middleText: "Your booking has been successfully completed",
          onConfirm: () {
            Get.offAll(const homeScreen());
            //Get.to(DashboardScreen());
          });

      // print(meetingdate.value.toString());
      // print(response);
      //Get.to(meetingSuccessScreen());
      //print("done");
    } catch (e) {
      print("erorr${e.toString()}");
    }
  }
}
