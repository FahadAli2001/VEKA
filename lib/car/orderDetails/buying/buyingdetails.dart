import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class buyingdetails extends StatelessWidget {
  const buyingdetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
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
                            backgroundImage: AssetImage("assets/car.png"),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text("AUDI A3"),
                          subtitle: Text("\$450",
                            style: TextStyle(
                                color: Colors.green
                            ),),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.black
                        ,)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
