import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/Mybookmark/rents/rents.dart';

import '../ReviewSubmission/RentReviewSubmission.dart';
import 'rentPatmentController.dart';

class rentPayment extends StatelessWidget {
  const rentPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentPaymentController rpc = Get.put(rentPaymentController());

    var payment = "cash".obs;

    var _value = false.obs;
    void _handleRadioValueChanged(val) {
      _value.value = val;
    }

    var data = Get.arguments;
    List<Step> step = [
      Step(
        title: Text(""),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.28,
                decoration: BoxDecoration(
                    //color: Colors.pink,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adults",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.06),
                              ),
                              //
                              Text(
                                "Age 18+",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.03),
                              ),
                            ],
                          ),
                          //------

                          //-----
                          Obx(
                            () => Container(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      rpc.subAdults();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      rpc.adultCount.value.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Get.width * 0.05),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      rpc.addAdults();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Childrens",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.06),
                              ),
                              //
                              Text(
                                "Age 2-18",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.03),
                              ),
                            ],
                          ),
                          //------

                          //-----
                          Obx(
                            () => Container(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      rpc.subChildren();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      rpc.childrenCount.value.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Get.width * 0.05),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      rpc.addChildren();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Infants",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.06),
                              ),
                              //
                              Text(
                                "Age 0-2",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Get.width * 0.03),
                              ),
                            ],
                          ),
                          //------

                          //-----
                          Obx(
                            () => Container(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      rpc.subInfant();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      rpc.infantCount.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Get.width * 0.05),
                                    ),
                                  ),
                                  //
                                  InkWell(
                                    onTap: () {
                                      rpc.addInfant();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PAYMENT METHOD",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.06),
                ),
              ),
              //----
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Obx(
                  () => Container(
                    height: Get.height * 0.06,
                    width: Get.width,
                    //color: Colors.red,
                    child: RadioListTile(
                      title: Text("Cash On Delivery"),
                      value: "Cash On Delivery",
                      groupValue: payment.value,
                      onChanged: (val) {
                        payment.value = val.toString();
                      },
                    ),
                  ),
                ),
              ),
              //----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Obx(
                  () => Container(
                    height: Get.height * 0.06,
                    width: Get.width,
                    //color: Colors.red,
                    child: RadioListTile(
                      title: Text("Online Payment"),
                      value: "Online Payment",
                      groupValue: payment.value,
                      onChanged: (val) {
                        payment.value = val.toString();
                      },
                    ),
                  ),
                ),
              ),
              //-------
            ],
          ),
        ),
      ),
      Step(title: Text(""), content: Text(""), isActive: true),
      Step(
        title: Text(""),
        content: Text(""),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GestureDetector(
          onTap: () {
            Get.to(RetReviewSubmission(), arguments: {
              "houseprice": data["houseprice"],
              "housename": data["housename"],
              "houseimage": data["houseimage"],
              "adultcount": rpc.adultCount.value,
              "childcount": rpc.childrenCount.value,
              "totalprice": data!["totalprice"],
              "id": data!["id"],
              "isSelected": data["isSelected"]
            });
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.06,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Center(
              child: Text("NEXT"),
            ),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
            accentColor: Colors.red,
            primaryColor: Colors.red,
            colorScheme: ColorScheme.light(primary: Colors.red)),
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
