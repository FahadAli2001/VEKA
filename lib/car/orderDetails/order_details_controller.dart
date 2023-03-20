import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Token/AccessToken.dart';

class OrderDetailsController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());
  List<Map> ordersRent = [];
  List<Map> ordersBuy = [];
  RxBool isRent = false.obs;
  RxBool isOrderGet = false.obs;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  Future<void> getOrders() async {
    String url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/orders";
    
    isOrderGet.value = true;

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'))}',
          'wc-authentication':
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        for (var element in data) {
         
          getProductById(element['line_items'][0]['product_id'].toString())
              .then((value) {
            if (value['type'] != "simple") {
              ordersRent.add({
                'name': element['line_items'][0]['name'].toString(),
                'price': element['line_items'][0]['price'].toString(),
                'image': element['line_items'][0]['price'].toString(),
                'product_id': element['line_items'][0]['product_id'].toString(),
              });
            } else {
              ordersBuy.add({
                'name': element['line_items'][0]['name'].toString(),
                'price': element['line_items'][0]['price'].toString(),
                'image': element['line_items'][0]['price'].toString(),
                'product_id': element['line_items'][0]['product_id'].toString(),
              });
            }
          });
        }
      } else {}
    } catch (e) {
      isOrderGet.value = false;
      print(e);
    }
  }

  Future<dynamic> getProductById(String id) async {
    String url =
        "https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products/$id";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'))}',
          'wc-authentication':
              'ck_35efc60387133919ea7a6e22c34a2201af711f47:cs_650113cb966d76d8f9f926b41f9a894186e2dcd6',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
