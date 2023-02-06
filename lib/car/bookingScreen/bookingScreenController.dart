import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:woocommerce_api/woocommerce_api.dart';

class bookingScreenController extends GetxController{
  var pickupdate = DateTime.now().obs;
  var dropOfdate = DateTime.now().obs;
  var persondropdownvalue = '1'.obs;
  var carqntyvalue = '1'.obs;
  var paymenttypevalue = 'cash on delivery'.obs;
  var childrenvalue = false.obs;
  var babyvalue = false.obs;
  RxInt total = 0.obs;
  RxInt subtotal = 0.obs;
  //var nofdays = 1.obs;

  /*checkdays(){
    var difference = dropOfdate.value.difference(pickupdate.value).obs;
    var nofdays = difference.value.inDays;
    return nofdays;
  }*/




  var persons = [
    '1',
    '2',
    '3',
    '4',
  ];



  void personSelected(String value){
    persondropdownvalue.value = value;
  }
  var carqnty = [
    '1',
    '2',
    '3',
    '4',
  ];


  void carqntySelected(String value){
    carqntyvalue.value = value;
  }

  var paymenttype = [
    "cash on delivery",
    "online payment"
  ];



  void paymentTypeSelected(String value){
    paymenttypevalue.value = value;
  }


  void handleRadioValueChanged(val) {
    babyvalue.value = val;
  }


  void handleRadioValueChanged1(val) {
    childrenvalue.value = val;
  }
  List checkboxes = [];
   pricewidget(iselected, List charges,List names){
     //widgets.clear();
     for (var entry in iselected.asMap().entries) {
       checkboxes.clear();
       for (int i = 0; i < charges.length; i++) {
         if (iselected[i] == true) {
           checkboxes.add(charges[i]);
         } else {
           checkboxes.add("0");
         }
       }
     }
     return checkboxes;
  }



  int totalcarPrice(List isSelected , List charges, carprice){
    var difference = dropOfdate.value.difference(pickupdate.value).obs;
    var nofdays = difference.value.inDays;

     total.value = int.parse(carprice)* int.parse(carqntyvalue.value) * nofdays ;
     print(total.value);
    for (var entry in isSelected.asMap().entries) {
      if (entry.value == true) {
        print('Index ${entry.key} has value of true');
        total.value += (int.parse(charges[entry.key]));
      }

    }
    return total.value;
  }

  //RxList element= [].obs;
  var picklocation;
  var pick = "a".obs;
  Future getpicklocation()async{
    try {
      final response = await http.get(
        Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/location"),
        headers: {
          'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
          'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
        },
      );

      if(response.statusCode == 200){
        picklocation = json.decode(response.body);

      }
    }
    catch(e){
      print(e);

    }
    return picklocation;
  }

  var droplocation;
  var drop = "a".obs;
  Future getdroplocation()async{
    try {
      final response = await http.get(
        Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/location"),
        headers: {
          'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
          'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
        },
      );

      if(response.statusCode == 200){
        droplocation = json.decode(response.body);

      }
    }
    catch(e){
      print(e);

    }
    return droplocation;
  }


}