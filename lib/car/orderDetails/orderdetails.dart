import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/orderDetails/buying/buyingdetails.dart';
import 'package:veka/car/orderDetails/rent/rent.dart';

import 'order_details_controller.dart';

class Orderdetails extends StatelessWidget {
  Orderdetails({Key? key}) : super(key: key);

  OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());

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
            "Order Details",
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
          bottom: TabBar(
            indicatorColor: Colors.black,
            
            onTap: (index) {
              if (index == 0) {
                orderDetailsController.isRent.value = true;
              } else {
                orderDetailsController.isRent.value = false;
              }
            },
            tabs: const [
              Tab(
                text: "Rent",
              ),
              Tab(
                text: "Buying",
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AutoMobileRent(orderDetailsController: orderDetailsController),
            AutoMobileRent(orderDetailsController: orderDetailsController)
          ],
        ),
      ),
    );
  }
}
