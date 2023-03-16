
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/Mybookmark/rents/rents.dart';
import 'package:veka/house/Bookmarks/rents/rents.dart';

class RealStateBookmark extends StatelessWidget {
  const RealStateBookmark({Key? key}) : super(key: key);

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
            onPressed: () {
              Get.back();
            },
            icon: const Icon(CupertinoIcons.back),
            color: Colors.black,
          ),
          title: Text(
            "My Bookmarks",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Get.width * 0.05),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(
                  CupertinoIcons.person_alt,
                  color: Colors.black,
                ),
              ),
            )
          ],
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                text: "Rents",
              ),
              Tab(
                text: "Buying",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RealStateRentTab(
              isBuy: true,
            ),
            RealStateRentTab(
              isBuy: false,
            ),
          ],
        ),
      ),
    );
  }
}
