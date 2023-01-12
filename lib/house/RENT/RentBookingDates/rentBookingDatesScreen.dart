import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:veka/house/RENT/rentPayment/rentPaymnet.dart';


class rentBookingDatesScreen extends StatelessWidget {
  const rentBookingDatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkIndate = DateTime.now().obs;
    var checkOutdate = DateTime.now().obs;
    return  SingleChildScrollView(
      child:  Column(
          children: [
            Text("Available Dates",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: Get.width * 0.06
            ),),
            //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
              child: Container(
                width: Get.width *0.9,

                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2040, 12, 31),
                    focusedDay: DateTime.now(),
                  ),
                )

                ),
              ),
            //
            Align(
              alignment: Alignment.topLeft,
              child: Text("Fill this box",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width * 0.05
              ),),
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
                        child: Text("CheckInDate",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04
                        ),),
                      ),
                      //
                      Container(
                        width: Get.width / 2.8,
                        height: Get.height * 0.06,
                        color: Colors.grey.shade400,
                        child:TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.date,
                          initTime: checkIndate.value,
                          minTime: DateTime.now().subtract(const Duration(days: 10)),
                          maxTime: DateTime.now().add(const Duration(days: 10)),
                          barrierColor: Colors.black12, //Barrier Color when pop up show
                          onChange: (dateTime) {
                            // Implement your logic with select dateTime
                            checkIndate.value = dateTime;
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
                        child: Text("CheckOutDate",
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.04
                          ),),
                      ),
                      //
                      Container(
                        width: Get.width / 2.8,
                        height: Get.height * 0.06,
                        color: Colors.grey.shade400,
                        child:TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.date,
                          initTime: checkOutdate.value,
                          minTime: DateTime.now().subtract(const Duration(days: 10)),
                          maxTime: DateTime.now().add(const Duration(days: 10)),
                          barrierColor: Colors.black12, //Barrier Color when pop up show
                          onChange: (dateTime) {
                            // Implement your logic with select dateTime
                            checkOutdate.value = dateTime;
                          },

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
              child: GestureDetector(
                onTap: (){
                  Get.to(rentPayment());
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
                    child: Text("NEXT"),
                  ),
                ),
              ),
            )
        ]
            ),





    );
  }
}
