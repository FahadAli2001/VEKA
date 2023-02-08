import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../rentPayment/rentPatmentController.dart';

class RetReviewSubmission extends StatelessWidget {
  const RetReviewSubmission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentPaymentController rpc = Get.put(rentPaymentController());

    var data = Get.arguments;

    List<Step>step=[
      Step(

        title: Text(""), content: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Review Your Submission",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: Get.width * 0.05
              ),),
              //--------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: Get.width ,
                  height: Get.height * 0.1,
                 // color: Colors.purple,
                  child: Row(
                    children: [
                      Container(
                        width: Get.width * 0.3,
                        height: Get.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/home.png"),
                          fit: BoxFit.cover)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Superior Double Room",style: TextStyle(
                              fontSize: Get.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),),
                            Text("\$45",style: TextStyle(
                                fontSize: Get.width * 0.04,

                                color: Colors.red
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //----------
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.36,
                      width: Get.width / 2,
                      // color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Full Name",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Get.width * 0.04
                              ),),
                            Card(
                              elevation: 2,
                              child: Container(
                                color: Colors.grey.shade200,
                                width: Get.width / 0.2,
                                height: Get.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("ABC"),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //
                            SizedBox(height: 5,),
                            //
                            Text("Adults",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Get.width * 0.04
                              ),),
                            //
                            Card(
                              elevation: 2,
                              child: Container(
                                color: Colors.grey.shade200,
                                width: Get.width / 0.2,
                                height: Get.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data["adultcount"].toString()),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //
                            SizedBox(height: 5,),
                            //
                            Text("Children",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Get.width * 0.04
                              ),),
                            Card(
                              elevation: 2,
                              child: Container(
                                color: Colors.grey.shade200,
                                width: Get.width / 0.2,
                                height: Get.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data["childcount"].toString()),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //-----

                  ],
                ),
              ),
              //-------------
              Align(
                alignment: Alignment.topLeft,
                child: Text("Payment Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: Get.width * 0.05
                  ),),
              ),
              //------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.04
                      ),
                    ),
                    Text("\$45",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: Get.width * 0.04
                      ),
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
                    Text("Deposit (50%)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.04
                      ),
                    ),
                    Text("\$45",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: Get.width * 0.04
                      ),
                    ),
                  ],
                ),
              ),
              //---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.04
                      ),
                    ),
                    Text("\$${data["totalprice"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: Get.width * 0.06
                      ),
                    ),
                  ],
                ),
              ),
              //---
            ],
          ),
        ),
      ),),
      Step(title: Text(""), content:Text(""
      )),
      Step(title: Text(""), content: Text(""),isActive: true),

    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: GestureDetector(
          onTap: (){
            print("tapp");
            //print(data["isSelected"]);
            rpc.requestForBuyHouse(data["id"],data["isSelected"]);
            //print(data["id"]);
            //print(data["totalprice"]);
          //  Get.to(bookingSucessfully());
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey
                )
            ),
            child: Center(
              child: Text("BOOKED"),
            ),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
            accentColor: Colors.red,
            primaryColor: Colors.red,
            colorScheme: ColorScheme.light(
                primary: Colors.red
            )
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: step,
          controlsBuilder: (context, controller) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
