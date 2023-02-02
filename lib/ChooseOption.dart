import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/welcome/welcomeScreen.dart';
import 'package:veka/house/login/loginScreen.dart';

import 'car/Dashboard/dashboardScreen.dart';

class ChooseOption extends StatelessWidget {
  const ChooseOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () async{
                SharedPreferences sp =await SharedPreferences.getInstance();
                (sp.getString("username")!=null)?Get.to(() => DashboardScreen()): Get.to(welcomeScreen());

              },
              child: Center(
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      //color: Colors.green,
                      image: DecorationImage(
                          image: AssetImage("assets/Veka-Green.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: InkWell(
              onTap: () {
                Get.to(loginSxreen());
              },
              child: Center(
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      //  color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage("assets/Veka-Red.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
