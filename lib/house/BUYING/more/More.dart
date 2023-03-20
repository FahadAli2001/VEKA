import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/AboutUs/aboutUs.dart';
import '../../Bookmarks/realstate_bookmark.dart';
import '../../login/LoginController.dart';
import '../../login/loginScreen.dart';
import '../../orderDetails/orderdetails.dart';

class More extends StatelessWidget {
  final bool isRent;
  const More({Key? key, required this.isRent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color boxColor = Colors.grey.shade300;
    Color circleColor = Colors.grey.shade400;
    var icon = Get.width * 0.05;
    var circle = Get.width * 0.05;
    var boxheight = Get.height * 0.08;
    var textSize = Get.width * 0.045;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                homesignin.remove("name");
                homesignin.remove("Email");
                homesignin.remove("password");
                homesignin.remove("realStateUserId");
                Get.offAll(loginSxreen());
              },
              child: Container(
                width: Get.width * 0.4,
                height: Get.height * 0.8,
                color: Colors.red.shade300,
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
      ),
      // Get.to(const RealStateBookmark());
      appBar: AppBar(
        title: Image.asset(
          "assets/Veka-Red.png",
          height: 180,
          width: 150,
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 18,
                  ),
                  // SizedBox(height: 5,),
                  Text(
                    "Hi, Belly",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.white12,
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "More",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.05),
                ),
              ),
            ),
            //
            GestureDetector(
              onTap: () {
                Get.to(RealStateOrderdetails(
                  isRent: isRent,
                ));
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: boxColor,
                          width: Get.width * 0.85,
                          height: boxheight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: circle,
                                  backgroundColor: circleColor,
                                  child: Icon(
                                    Icons.shopping_bag,
                                    color: Colors.black,
                                    size: icon,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Order Details",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: textSize),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 325),
                        child: CircleAvatar(
                            radius: Get.width * 0.04,
                            backgroundColor: boxColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey.shade500,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            //
            GestureDetector(
              onTap: () {
                Get.to(const RealStateBookmark());
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: boxColor,
                          width: Get.width * 0.85,
                          height: boxheight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: circle,
                                  backgroundColor: circleColor,
                                  child: Icon(
                                    CupertinoIcons.bookmark_fill,
                                    color: Colors.black,
                                    size: icon,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "My Book Marks",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: textSize),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 325),
                        child: CircleAvatar(
                            radius: Get.width * 0.04,
                            backgroundColor: boxColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey.shade500,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            //--------
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: boxColor,
                          width: Get.width * 0.85,
                          height: boxheight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: circle,
                                  backgroundColor: circleColor,
                                  child: Icon(
                                    Icons.car_rental_sharp,
                                    color: Colors.black,
                                    size: icon,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Service Mode",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: textSize),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 325),
                        child: CircleAvatar(
                            radius: Get.width * 0.04,
                            backgroundColor: boxColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey.shade500,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            //--------about us
            GestureDetector(
              onTap: () {
                Get.to(() => const aboutUs());
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: boxColor,
                          width: Get.width * 0.85,
                          height: boxheight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: circle,
                                  backgroundColor: circleColor,
                                  child: Icon(
                                    Icons.note_alt_rounded,
                                    color: Colors.black,
                                    size: icon,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "About Us",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: textSize),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 325),
                        child: CircleAvatar(
                            radius: Get.width * 0.04,
                            backgroundColor: boxColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey.shade500,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            //--------
          ],
        ),
      ),
    );
  }
}
