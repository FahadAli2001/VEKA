import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../MeetingSuccess/meetingSuccessScreen.dart';

class buyingMeeting extends StatelessWidget {
  const buyingMeeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
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
                Get.to(meetingSuccessScreen());
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
                  child: Text("DONE",
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("DATE"),
                              Icon(Icons.calendar_month_rounded)
                            ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("TIME"),
                              Icon(Icons.watch_later)
                            ],
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



