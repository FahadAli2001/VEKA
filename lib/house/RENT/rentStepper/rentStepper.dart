import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../RentBookingDates/rentBookingDatesScreen.dart';
import '../rentPayment/rentPaymnet.dart';

class rentStepper extends StatelessWidget {
  const rentStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Step>step=[
      Step(
        isActive: true,
        title: Text(""), content: rentBookingDatesScreen(),),
      Step(title: Text(""), content: Text(""),
      ),
      Step(title: Text(""), content: Text(""),),



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
