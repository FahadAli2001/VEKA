import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/house/orderDetails/rent/rent.dart';

import 'order_details_controller.dart';

class RealStateOrderdetails extends StatelessWidget {
  bool isRent;
  RealStateOrderdetails({Key? key,required this.isRent}) : super(key: key);

  RealStateOrderDetailsController orderDetailsController =
      Get.put(RealStateOrderDetailsController());

  @override
  Widget build(BuildContext context) {
    orderDetailsController.isRent.value = isRent;
    return Scaffold(
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
      ),
      body: RealStateRent(
        orderDetailsController: orderDetailsController,
      ),
    );
  }
}
