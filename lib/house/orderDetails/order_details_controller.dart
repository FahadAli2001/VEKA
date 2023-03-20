import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../car/Token/AccessToken.dart';

class RealStateOrderDetailsController extends GetxController {
  AcessToken acessToken = Get.put(AcessToken());
  RxList ordersRent = [].obs;
  RxList ordersBuy = [].obs;
  RxBool isRent = false.obs;
  RxBool isOrderGet = false.obs;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  Future<void> getOrders() async {
    String url =
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/orders";
    isOrderGet.value = true;

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
          getProductById(element['line_items'][0]['product_id'].toString())
              .then((value) {
            String temp = value['type'];
            if (temp == "ovacrs_car_rental") {
              ordersRent.add({
                'name': element['line_items'][0]['name'].toString(),
                'price': element['line_items'][0]['price'].toString(),
                'image': element['line_items'][0]['image']['src'].toString(),
                'product_id': element['line_items'][0]['product_id'].toString(),
              });
            } else if (temp == "simple") {
              ordersBuy.add({
                'name': element['line_items'][0]['name'].toString(),
                'price': element['line_items'][0]['price'].toString(),
                'image': element['line_items'][0]['image']['src'].toString(),
                'product_id': element['line_items'][0]['product_id'].toString(),
              });
            }
          });
        }
        isOrderGet.value = false;
      } else {
        isOrderGet.value = false;
      }
    } catch (e) {
      isOrderGet.value = false;
      print(e);
    }
  }

  Future<dynamic> getProductById(String id) async {
    String url =
        "https://vekarealestate.technopreneurssoftware.com/wp-json/wc/v3/products/$id";

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
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
