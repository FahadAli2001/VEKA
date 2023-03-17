import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../MeetingSuccess/meetingSuccessScreen.dart';
import 'buyingMeetingController.dart';

class buyingMeeting extends StatefulWidget {
  const buyingMeeting({Key? key}) : super(key: key);

  @override
  State<buyingMeeting> createState() => _buyingMeetingState();
}

class _buyingMeetingState extends State<buyingMeeting> {

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    buyingMeetingController bmc = Get.put(buyingMeetingController());
    var data = Get.arguments;

    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.09,
        // color: Colors.teal,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            child: InkWell(
              onTap: (){
                setState(() {
                  isDone = true;
                });
                bmc.requestForBuyHouse(data["id"]).then((value) {
                  setState(() {
                    isDone = false;
                  });
                }).catchError((onError){
                  setState(() {
                    isDone = false;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                width: Get.width,
                height: Get.height,
                child: Center(
                  child: isDone ? const CircularProgressIndicator(
                    color: Colors.black,
                  ) : Text("DONE",
                    style: TextStyle(
                        fontSize: Get.width * 0.05
                    ),),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("buy meeting",
        style: TextStyle(
          color: Colors.black
        ),),
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.15,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Choose your meeting date",
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: Get.width * 0.05
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Get.width * 0.4,
                          color: Colors.white,
                          height: Get.height * 0.05,
                          child:TimePickerSpinnerPopUp(
                            mode: CupertinoDatePickerMode.date,
                            initTime: bmc.meetingdate.value,
                            barrierColor: Colors.black12, //Barrier Color when pop up show
                            onChange: (dateTime) {
                              // Implement your logic with select dateTime
                              bmc.meetingdate.value = dateTime;
                            },

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.15,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Choose your meeting Time",
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: Get.width * 0.05
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Get.width * 0.4,
                          color: Colors.white,
                          height: Get.height * 0.05,
                          child: TimePickerSpinnerPopUp(
                            mode: CupertinoDatePickerMode.time,
                            initTime: bmc.meetingtime.value,
                            barrierColor: Colors.black12, //Barrier Color when pop up show
                            onChange: (dateTime) {
                              // Implement your logic with select dateTime
                              bmc.meetingtime.value = dateTime;
                            },

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



