import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class machanicalRepair extends StatelessWidget {
  const machanicalRepair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width,
                height: Get.height * 0.13,
               // color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                   //   color: Colors.pink,
                      height: Get.height * 0.13,
                      width: Get.width * 0.5,
                      child: ListTile(
                        leading: SizedBox(

                          width: Get.width * 0.2,
                          height: Get.height ,
                          child: Icon(Icons.person,
                          size: 90,),
                        ),
                        title: Text("John",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.05
                        ),),
                        subtitle: Text("4.4"),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Ac Repair",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.width * 0.035
                            ),),
                          Container(
                            width: Get.width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green
                              )
                            ),
                            child: CupertinoButton(child: Text("Contact",

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: Get.width * 0.04
                            ),),
                                onPressed: (){}),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
