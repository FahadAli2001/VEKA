import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CarHomePageController{

  var data;

   fetchData()async
   {
     try{

       var response = await http.get(Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wc/v3/products"));
       if(response.statusCode == 200){
         data = jsonDecode(response.body.toString());
       }
     }
     catch(e){
       Get.snackbar("Error", e.toString(),
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.grey
       );
     }
   }
}