import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/AboutUs/aboutUs.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color boxColor = Colors.grey.shade300;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: null,
        title: Text("More",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Get.width * 0.05
          ),),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                },
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height:  Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: Get.width * 0.07,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            CupertinoIcons.lock_fill,
                            color: Colors.black,
                            size: Get.width * 0.07,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Order Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05
                            ),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(
                                CupertinoIcons.arrow_right_circle_fill
                            ),
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
                onTap: (){

                },
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height:  Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: Get.width * 0.07,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            CupertinoIcons.bookmark_fill,
                            color: Colors.black,
                            size: Get.width * 0.07,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("My Book Marks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05
                            ),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(
                                CupertinoIcons.arrow_right_circle_fill
                            ),
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
                onTap: (){

                },
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height:  Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: Get.width * 0.07,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.car_rental_sharp,
                            color: Colors.black,
                            size: Get.width * 0.07,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Service Mode",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05
                            ),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(
                                CupertinoIcons.arrow_right_circle_fill
                            ),
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
              onTap: (){
                Get.to(aboutUs());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: boxColor,
                  width: Get.width,
                  height:  Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: Get.width * 0.07,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.note_alt_rounded,
                            color: Colors.black,
                            size: Get.width * 0.07,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("About us",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05
                            ),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Icon(
                                CupertinoIcons.arrow_right_circle_fill
                            ),
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
