import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../BUYING/dashboard/houseDashboard.dart';

class bookingSucessfully extends StatefulWidget {
   bookingSucessfully({Key? key}) : super(key: key);

  @override
  State<bookingSucessfully> createState() => _bookingSucessfullyState();
}

class _bookingSucessfullyState extends State<bookingSucessfully> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4),
            ()=>Get.to(
            houseDashboard()
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,
              size: 100,
              color: Colors.red,),
            Text("Your booking is successfully done")
          ],
        ),
      ),
    );
  }
}
