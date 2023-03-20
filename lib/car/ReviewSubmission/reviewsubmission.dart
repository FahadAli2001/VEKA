import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/car/bookingScreen/bookingScreenController.dart';
import 'RentReviewSubmissionController.dart';

class ReviewSubmission extends StatefulWidget {
  const ReviewSubmission({Key? key}) : super(key: key);

  @override
  State<ReviewSubmission> createState() => _ReviewSubmissionState();
}

class _ReviewSubmissionState extends State<ReviewSubmission> {
  bool isDone = false;
  RentReviewSubmissionController rrsc =
      Get.put(RentReviewSubmissionController());
  bookingScreenController bsc = Get.put(bookingScreenController());

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    var totalprice =
        int.parse(data["carprice"]) * int.parse(bsc.carqntyvalue.value);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/Veka-Green.png",
          height: 180,
          width: 150,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white12,
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
              rrsc.postRentOrder(data["id"], data["rxisSelected"]);
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
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.width * 0.04),
                                ),
                                subtitle: Text(
                                  "\$ ${data["carprice"].toString()}",
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
                  //height: Get.height * 0.1,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
                            AutoSizeText(
                              data["carname"],
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(
                                color: Colors.black,
                                //  fontSize: Get.width * 0.04
                              ),
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
                              data["carqnty"],
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
                              "\$ ${totalprice.toString()}",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Container(
                    width: Get.width,
                    //height: Get.height * 0.1,
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
                                "Extra services",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04),
                              ),
                              for (var i = 0;
                                  i < data["extraservices"].length;
                                  i++) ...[
                                Text(
                                  data["extraservices"][i],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.04),
                                ),
                              ]
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
                              //
                              for (var i = 0;
                                  i < data["charges"].length;
                                  i++) ...[
                                Text(
                                  data["charges"][i].toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.04),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Container(
                    height: Get.height * 0.12,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "+ Add notes",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: Get.width * 0.04),
                              ),
                              const Radio(
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
                        data["totalprice"].toString(),
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
                        "\$50",
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
                        "\$${data["totalprice"].toString()}",
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
