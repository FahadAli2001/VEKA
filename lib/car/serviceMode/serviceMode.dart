import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/serviceMode/maintainance/maintainance.dart';
import 'package:veka/car/serviceMode/mechanicalRepair/mechanicalRepair.dart';

class serviceMode extends StatelessWidget {
  const serviceMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white70,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(CupertinoIcons.back),
            color: Colors.black,
          ),
          title: Text("Service Mode",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Get.width * 0.05
            ),),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(CupertinoIcons.person_alt,
                  color: Colors.black,),
              ),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,

            tabs: [
              Tab(text: "Maintainance",),
              Tab(text: "Mechanical Repair",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            maintainance(),
            machanicalRepair(),
          ],
        ),
      ),
    );
  }
}
