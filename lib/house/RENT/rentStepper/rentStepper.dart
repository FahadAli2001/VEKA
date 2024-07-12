import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../RentBookingDates/rentBookingDatesController.dart';
import '../RentBookingDates/rentBookingDatesScreen.dart';

class rentStepper extends StatelessWidget {
  const rentStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RentBookingDatesController());
    var data = Get.arguments;
    List<Step> step = [
      Step(
        isActive: true,
        title: Text(""),
        content: rentBookingDatesScreen(
            houseName: data["housename"],
            houseImage: data["houseimage"],
            extraservices: data["extraservices"],
            extraservicescharges: data["extraservicescharges"],
            houseprice: data["houseprice"],
            id: data["id"]),
      ),
      Step(
        title: Text(""),
        content: Text(""),
      ),
      Step(
        title: Text(""),
        content: Text(""),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
      ),
      body: Theme(
        data: ThemeData(
            hintColor: Colors.red,
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
