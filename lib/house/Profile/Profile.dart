import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/LoginController.dart';
import '../login/loginScreen.dart';



class HomeProfileScreen extends StatelessWidget {
  const HomeProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    loginController lc = Get.put(loginController());

    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.08,
        //  color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: ()async{
              SharedPreferences homesp =await SharedPreferences.getInstance();
              homesp.remove("username" );
              homesp.remove("password" );
              Get.to(loginSxreen());
            },
            child: Container(
              width: Get.width * 0.4,
              height: Get.height * 0.8,
              color: Colors.green,
              child: Center(
                child: Text("LogOut",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.04
                  ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
