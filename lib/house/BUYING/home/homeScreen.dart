import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../RENT/dashboard/dashboard.dart';
import '../dashboard/houseDashboard.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            //  color: Colors.green,
          ),
          Container(
            width: Get.width,
            height: Get.height * 0.59,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/house.jpg"),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi belly",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: Get.width * 0.09),
                  ),
                  //-------
                  Text(
                    "Here you can get new deals",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: Get.width * 0.04),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 450,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              width: Get.width,
              height: Get.height * 0.45,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "I Want To",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.07),
                        ),
                      ),
                    ),
                    //-----
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height * 0.28,
                        //color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const houseDashboard(isRent: false,));
                                  },
                                  child: Container(
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.18,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image:
                                                AssetImage("assets/home.png"),
                                            fit: BoxFit.fill),
                                        //  color: Colors.pink,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                Text(
                                  "BUY",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.07),
                                )
                              ],
                            ),
                            //-----
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const dashboard(
                                      isRent: true,
                                    ));
                                  },
                                  child: Container(
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.18,
                                    decoration: BoxDecoration(
                                      //color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage("assets/rent.jpg"),
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high),
                                    ),
                                  ),
                                ),
                                Text(
                                  "RENT",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.07),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
