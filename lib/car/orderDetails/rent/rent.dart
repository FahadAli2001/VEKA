import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../order_details_controller.dart';

// ignore: must_be_immutable
class AutoMobileRent extends StatelessWidget {
  final bool isRent;
  AutoMobileRent({Key? key, required this.isRent}) : super(key: key);

  OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderDetailsController.isOrderGet.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orderDetailsController.ordersRent.isNotEmpty
              ? MyOrders(orderDetailsController: orderDetailsController)
              : orderDetailsController.ordersBuy.isNotEmpty
                  ? MyOrders(orderDetailsController: orderDetailsController)
                  : const Center(
                      child: Text("No Orders"),
                    ),
    );
  }
}

class MyOrders extends StatelessWidget {
  final OrderDetailsController orderDetailsController;
  const MyOrders({super.key, required this.orderDetailsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
            itemCount: orderDetailsController.ordersRent.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.11,
                  //color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/car.png"),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text("AUDI A3"),
                          subtitle: Text(
                            "\$450",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
