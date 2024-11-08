import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboardScreen.dart';
import '../SignIn/SignInController.dart';
import 'BuyReviewController.dart';

class buyReviewSubmission extends StatefulWidget {
  const buyReviewSubmission({Key? key}) : super(key: key);

  @override
  State<buyReviewSubmission> createState() => _buyReviewSubmissionState();
}

class _buyReviewSubmissionState extends State<buyReviewSubmission> {
  bool isDone = false;
  BuyReviewController brc = Get.put(BuyReviewController());
  SignInController sic = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: Get.height * 0.04,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.09,
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: CupertinoButton(
            color: Colors.green,
            onPressed: () {
              setState(() {
                isDone = true;
              });
              brc.postProduct(data["id"], data["carprice"]).then((value) {
                setState(() {
                  isDone = false;
                });
              });
            },
            child: isDone
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Text(
                    "Done",
                    style: TextStyle(
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Review Your Submission",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.06),
                    ),
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              NetworkImage(data["carimage"].toString()),
                        ),
                        Container(
                            width: Get.width * 0.6,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ListTile(
                                title: Text(
                                  data["carname"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.width * 0.04),
                                ),
                                subtitle: Text(
                                  "\$ ${data["carprice"]}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: Get.width * 0.04),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                //
                Container(
                  width: Get.width,
                  height: Get.height * 0.1,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Car Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                            Text(
                              data["carname"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                          ],
                        ),
                        //------
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Qty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                            Text(
                              "1",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                          ],
                        ),
                        //-------
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                            Text(
                              "\$ ${data["carprice"].toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //--------

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Container(
                    height: Get.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Instructions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04),
                              ),
                              Text(
                                "Cash on delivery",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04),
                              ),
                            ],
                          ),

                          //-------
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "+ Add notes",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: Get.width * 0.04),
                              ),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //----
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.04),
                      ),
                      Text(
                        data["carprice"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: Get.width * 0.04),
                      ),
                    ],
                  ),
                ),
                //--
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deposit (50%)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.04),
                      ),
                      Text(
                        "000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: Get.width * 0.04),
                      ),
                    ],
                  ),
                ),
                //---
                //--
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.04),
                      ),
                      Text(
                        data["carprice"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: Get.width * 0.06),
                      ),
                    ],
                  ),
                ),
                //---
              ],
            ),
          ),
        ),
      ),
    );
  }
}
