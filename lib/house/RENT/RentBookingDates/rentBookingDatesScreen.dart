import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:veka/house/RENT/rentPayment/rentPaymnet.dart';

import '../rentPayment/rentPatmentController.dart';
import 'rentBookingDatesController.dart';

class rentBookingDatesScreen extends StatelessWidget {
  var extraservices;
  var extraservicescharges;
  var houseprice;
  var id;
  rentBookingDatesScreen(
      {Key? key,
      required this.extraservices,
      required this.extraservicescharges,
      required this.houseprice,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentPaymentController rpc = Get.put(rentPaymentController());
    RxList<dynamic> rxisSelected = [].obs;
    rxisSelected.value = RxList.generate(extraservices.length, (_) => false);



    return Container(
      child: Column(children: [
        Text(
          "Available Dates",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: Get.width * 0.06),
        ),
        //
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Container(
              width: Get.width * 0.9,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2040, 12, 31),
                  focusedDay: DateTime.now(),
                ),
              )),
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Fill this box",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: Get.width * 0.05),
          ),
        ),
        //-----
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CheckInDate",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04),
                    ),
                  ),
                  //
                  Container(
                    width: Get.width / 2.8,
                    height: Get.height * 0.06,
                    color: Colors.grey.shade400,
                    child: TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.date,
                      initTime: rpc.checkIndate.value,
                      barrierColor:
                          Colors.black12, //Barrier Color when pop up show
                      onChange: (dateTime) {
                        // Implement your logic with select dateTime
                        rpc.checkIndate.value = dateTime;
                      },
                    ),
                  ),
                ],
              ),
              //
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CheckOutDate",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04),
                    ),
                  ),
                  //
                  Container(
                    width: Get.width / 2.8,
                    height: Get.height * 0.06,
                    color: Colors.grey.shade400,
                    child: TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.date,
                      //initTime: rpc.checkOutdate.value.add(Duration(days: 3)),
                      //minTime:  rpc.checkOutdate.value.add(Duration(days: 3)),
                      barrierColor:
                          Colors.black12, //Barrier Color when pop up show
                      onChange: (dateTime) {
                        // Implement your logic with select dateTime
                        rpc.checkOutdate.value = dateTime;
                        print(rpc.checkOutdate.value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Extra Services",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Get.width * 0.045),
          ),
        ),
        //
        for (var i = 0; i < extraservices.length; i++) ...[
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
                          extraservices[i].toString(),
                          style: TextStyle(fontSize: Get.width * 0.04),
                        ),
                        leading: Checkbox(
                            value: rxisSelected[i],
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
                    "\$${extraservicescharges[i].toString()}",
                    style: TextStyle(fontSize: Get.width * 0.04),
                  )
                ],
              ),
            ),
          ),
        ],
        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: GestureDetector(
            onTap: () {
              // rpc.totalhomePrice(rxisSelected, extraservicescharges, houseprice).toString();
              // print(houseprice);
              // print(;
              // print(rpc.total.value);
              Get.to(rentPayment(), arguments: {
                "isSelected": rxisSelected.value,
                "totalprice": rpc
                    .totalhomePrice(
                        rxisSelected, extraservicescharges, houseprice)
                    .toString(),
                "id": id
              });
              // print(rpc.totalhomePrice(rxisSelected, extraservicescharges, houseprice).toString());
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
        //
      ]),
    );
  }
}
