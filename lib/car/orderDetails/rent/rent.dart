import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order_details_controller.dart';

// ignore: must_be_immutable
class AutoMobileRent extends StatelessWidget {
  const AutoMobileRent({Key? key, required this.orderDetailsController})
      : super(key: key);

  final OrderDetailsController orderDetailsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => orderDetailsController.isOrderGet.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orderDetailsController.isRent.value
              ? orderDetailsController.ordersRent.isNotEmpty
                  ? MyOrders(orderDetailsController: orderDetailsController)
                  : const Center(
                      child: Text("No Orders"),
                    )
              : orderDetailsController.ordersBuy.isNotEmpty
                  ? MyOrders(orderDetailsController: orderDetailsController)
                  : const Center(child: Text("No Orders")),
    ));
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
            itemCount: orderDetailsController.isRent.value
                ? orderDetailsController.ordersRent.length
                : orderDetailsController.ordersBuy.length,
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
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: orderDetailsController.isRent.value
                                ? NetworkImage(orderDetailsController
                                    .ordersRent[index]["image"])
                                : NetworkImage(orderDetailsController
                                    .ordersBuy[index]["image"]),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: orderDetailsController.isRent.value
                              ? Text(orderDetailsController.ordersRent[index]
                                  ['name'])
                              : Text(orderDetailsController.ordersBuy[index]
                                  ['name']),
                          subtitle: Text(
                            orderDetailsController.isRent.value
                                ? "\$${orderDetailsController.ordersRent[index]['price']}"
                                : "\$${orderDetailsController.ordersBuy[index]['price']}",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
