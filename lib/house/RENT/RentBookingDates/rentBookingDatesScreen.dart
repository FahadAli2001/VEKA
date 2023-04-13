import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:veka/house/RENT/rentPayment/rentPaymnet.dart';

import '../rentPayment/rentPatmentController.dart';

class rentBookingDatesScreen extends StatelessWidget {
  var extraservices;
  var extraservicescharges;
  var houseprice;
  var id;

  var houseImage;

  var houseName;
  rentBookingDatesScreen(
      {Key? key,
      required this.houseName,
      required this.houseImage,
      required this.extraservices,
      required this.extraservicescharges,
      required this.houseprice,
      required this.id})
      : super(key: key);

  rentPaymentController rpc = Get.put(rentPaymentController());

  @override
  Widget build(BuildContext context) {
    RxList<dynamic> rxisSelected = [].obs;
    rxisSelected.value = RxList.generate(extraservices.length, (_) => false);
    TimePickerSpinnerController controller = TimePickerSpinnerController();

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
                child: FutureBuilder(
                    future: rpc.getOrders(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return TableCalendar(
                        calendarStyle: const CalendarStyle(
                          markersAlignment: Alignment.bottomCenter,
                        ),
                        calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, day, events) {
                          return rpc.eventDates.contains(
                                  "${day.day}:${day.month}:${day.year}")
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                )
                              : null;
                        }),
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2040, 12, 31),
                        focusedDay: DateTime.now(),
                      );
                    })),
          ),
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
                          color: Colors.grey.shade900(),
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
                      controller: controller,
                      mode: CupertinoDatePickerMode.date,
                      initTime: rpc.checkIndate.value,
                      barrierColor:
                          Colors.black12, //Barrier Color when pop up show
                      timeWidgetBuilder: (val) {
                        return GestureDetector(
                            onTap: () {
                              controller.showMenu();
                            },
                            child: Obx(
                              () => Container(
                                width: Get.width / 2.8,
                                height: Get.height * 0.06,
                                color: Colors.grey.shade400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${rpc.checkIndate.value.day}/${rpc.checkIndate.value.month}/${rpc.checkIndate.value.year}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.035),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      onChange: (dateTime) {
                        if (rpc.eventDates.contains(
                            "${dateTime.day}:${dateTime.month}:${dateTime.year}")) {
                          controller.menuIsShowing = false;
                          Get.snackbar("Error",
                              "This date is not available Please select another date",
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          rpc.checkIndate.value = dateTime;
                          controller.menuIsShowing = false;
                        }
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
                          color: Colors.grey.shade900(),
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
                      initTime:
                          rpc.checkOutdate.value.add(const Duration(days: 1)),
                      minTime:
                          rpc.checkOutdate.value.add(const Duration(days: 1)),
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
              Get.to(() => const rentPayment(), arguments: {
                "houseprice": houseprice,
                "housename": houseName,
                "houseimage": houseImage,
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
              child: const Center(
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
