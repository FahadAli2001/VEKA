import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class maintainance extends StatelessWidget {
  const maintainance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 3.5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: 3,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                         // color: Colors.orange,
                        image: DecorationImage(
                          image: AssetImage("assets/car.png"),
                          fit: BoxFit.cover
                        )
                      ),
                      width: Get.width,
                      height: Get.height * 0.12,

                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Oil Change",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("free Oil Change and ...........",
                        style: TextStyle(

                            color: Colors.black
                        ),),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
