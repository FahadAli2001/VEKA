import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/AboutUs/aboutUs.dart';

import '../../login/LoginController.dart';
import '../../login/loginScreen.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color boxColor = Colors.grey.shade300;
    var icon = Get.width * 0.05;
    var circle = Get.width * 0.05;
    var boxheight = Get.height * 0.08;
    loginController lc = Get.put(loginController());
    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.08,
        //  color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () async {
              SharedPreferences homesignin =
                  await SharedPreferences.getInstance();
              homesignin.remove("email");
              homesignin.remove("password");
              Get.offAll(loginSxreen());
            },
            child: Container(
              width: Get.width * 0.4,
              height: Get.height * 0.8,
              color: Colors.green,
              child: Center(
                child: Text(
                  "LogOut",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.04),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: null,
        title: Text(
          "More",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Get.width * 0.05),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height: boxheight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: circle,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            CupertinoIcons.lock_fill,
                            color: Colors.black,
                            size: icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Order Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(CupertinoIcons.arrow_right_circle_fill),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //--------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height: boxheight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: circle,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            CupertinoIcons.bookmark_fill,
                            color: Colors.black,
                            size: icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "My BookMarks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(CupertinoIcons.arrow_right_circle_fill),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //--------
            //--------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height: boxheight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: circle,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.car_rental_sharp,
                            color: Colors.black,
                            size: icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Service Mode",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(CupertinoIcons.arrow_right_circle_fill),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //--------------
            //--------
            GestureDetector(
              onTap: () {
                Get.to(aboutUs());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height: boxheight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: circle,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.note_alt_rounded,
                            color: Colors.black,
                            size: icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "About us",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(CupertinoIcons.arrow_right_circle_fill),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
