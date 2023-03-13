import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../ReviewSubmission/reviewsubmission.dart';

import 'bookingScreenController.dart';

class bookingScreen extends StatefulWidget {
  const bookingScreen({Key? key}) : super(key: key);

  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade300;
    var data = Get.arguments;
    bookingScreenController bsc = Get.put(bookingScreenController());

    RxList<dynamic> rxisSelected = [].obs;
    rxisSelected.value =
        RxList.generate(data!["extraservices"].length, (_) => false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white12,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Booking Form",
            style: TextStyle(color: Colors.black),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // print( bsc.totalcarPrice(rxisSelected.toList(), data["extraservicescharges"], data["carprice"]));
              //bsc.pricewidget(rxisSelected.toList(), data!["extraservicescharges"], data!["extraservices"]);
              //print(data["extraservices"]);
              Get.to(reviewsubmission(), arguments: {
                "carimage": data!["carimage"].toString(),
                "carname": data!["carname"].toString(),
                "carprice": data!["carprice"].toString(),
                "carqnty": bsc.carqntyvalue.value,
                "totalprice": bsc.totalcarPrice(rxisSelected.toList(),
                    data["extraservicescharges"], data["carprice"]),
                "extraservices": data!["extraservices"],
                "charges": bsc.pricewidget(rxisSelected,
                    data!["extraservicescharges"], data!["extraservices"]),
                "id": data!["id"],
                "rxisSelected": rxisSelected
              });
            },
            child: Container(
              width: Get.width / 1.4,
              height: Get.height * 0.06,
              color: Colors.green,
              child: Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.05),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: bsc.getdroplocation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            //height: Get.height * 0.35,
                            width: Get.width / 2,
                            // color: Colors.orange,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pick Up Location",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  //
                                  FutureBuilder(
                                    future: bsc.getpicklocation(),
                                    builder: (context, snapshot) {
                                      List<String> element = [];
                                      for (var i = 0;
                                          i < bsc.picklocation.length;
                                          i++) {
                                        element.add(snapshot.data[i]["title"]
                                                ['rendered']!
                                            .toString());
                                      }
                                      bsc.pick.value = element[0].toString();
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      }
                                      if (snapshot.hasData == null) {
                                        return Container();
                                      }
                                      if (snapshot.hasError) {
                                        return Container();
                                      }
                                      return Obx(
                                        () => Card(
                                          elevation: 2,
                                          child: Container(
                                            color: color,
                                            width: Get.width / 0.2,
                                            height: Get.height * 0.07,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton(
                                                  value: bsc.pick.toString(),
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: element
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    bsc.pick.value =
                                                        val.toString();
                                                  }),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  //
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //
                                  Text(
                                    "Pick Up Date",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(
                                      color: color,
                                      width: Get.width / 0.2,
                                      height: Get.height * 0.07,
                                      child: TimePickerSpinnerPopUp(
                                        mode: CupertinoDatePickerMode.date,
                                        initTime: bsc.pickupdate.value,
                                        barrierColor: Colors.black12,
                                        onChange: (dateTime) {
                                          bsc.pickupdate.value = dateTime;
                                        },
                                      ),
                                    ),
                                  ),
                                  //
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //
                                  Text(
                                    "Total Person",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  Obx(
                                    () => Card(
                                      elevation: 2,
                                      child: Container(
                                        color: color,
                                        width: Get.width / 0.2,
                                        height: Get.height * 0.07,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton(
                                              // Initial Value
                                              value:
                                                  bsc.persondropdownvalue.value,
                                              // Down Arrow Icon
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                              ),
                                              // Array list of items
                                              items: bsc.persons
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                bsc.personSelected(
                                                    val.toString());
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //-----
                          Container(
                            //height: Get.height * 0.36,
                            // color: Colors.green,
                            width: Get.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Drop Of Location",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  FutureBuilder(
                                    future: bsc.getdroplocation(),
                                    builder: (context, snapshot) {
                                      List<String> element = [];
                                      for (var i = 0;
                                          i < bsc.droplocation!.length;
                                          i++) {
                                        element.add(snapshot.data[i]["title"]
                                                ['rendered']!
                                            .toString());
                                      }
                                      bsc.drop.value = element[0].toString();
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      }
                                      if (snapshot.hasData == null) {
                                        return Container();
                                      }
                                      if (snapshot.hasError) {
                                        return Container();
                                      }
                                      return Obx(
                                        () => Card(
                                          elevation: 2,
                                          child: Container(
                                            color: color,
                                            width: Get.width / 0.2,
                                            height: Get.height * 0.07,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton(
                                                  value:
                                                      bsc.drop.value.toString(),
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: element
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    bsc.drop.value =
                                                        val.toString();
                                                  }),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  //
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //
                                  Text(
                                    "Drop Of Date",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(
                                      color: color,
                                      width: Get.width / 0.2,
                                      height: Get.height * 0.07,
                                      child: TimePickerSpinnerPopUp(
                                        mode: CupertinoDatePickerMode.date,
                                        initTime: bsc.dropOfdate.value,
                                        barrierColor: Colors.black12,
                                        onChange: (dateTime) {
                                          bsc.dropOfdate.value = dateTime;
                                        },
                                      ),
                                    ),
                                  ),
                                  //
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Get.width * 0.04),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Obx(
                                      () => Container(
                                        color: color,
                                        width: Get.width / 0.2,
                                        height: Get.height * 0.07,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton(
                                              value: bsc.carqntyvalue.value,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                              ),
                                              items: bsc.carqnty
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                bsc.carqntySelected(
                                                    val.toString());
                                              }),
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
                      padding: const EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.green, fontSize: Get.width * 0.04),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Obx(
                          () => Card(
                            elevation: 2,
                            child: Container(
                              color: color,
                              width: Get.width / 2.2,
                              height: Get.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                    value:
                                        bsc.paymenttypevalue.value.toString(),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                    items: bsc.paymenttype.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      bsc.paymentTypeSelected(val.toString());
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Extra Service",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          ),
                          Text(
                            "Charges",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.width * 0.05),
                          )
                        ],
                      ),
                    ),
                    //
                    for (var i = 0; i < data["extraservices"]!.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Get.width * 0.5,
                                child: Obx(
                                  () => ListTile(
                                    title: Text(
                                      data["extraservices"][i]!.toString(),
                                      style:
                                          TextStyle(fontSize: Get.width * 0.04),
                                    ),
                                    leading: Checkbox(
                                        value: rxisSelected[i]!,
                                        onChanged: (val) {
                                          // print(val);
                                          rxisSelected[i] = val!;
                                          /*print(val);
                                      bsc.handleRadioValueChanged(val);*/
                                        }),
                                  ),
                                ),
                              ),
                              Text(
                                "\$${data["extraservicescharges"][i]!.toString()}",
                                style: TextStyle(fontSize: Get.width * 0.04),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              );
            }));
  }
}
