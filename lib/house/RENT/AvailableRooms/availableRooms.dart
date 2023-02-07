import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../roomsDetails/roomDetails.dart';


class availableRooms extends StatelessWidget {
  const availableRooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        title: Text("Available Rooms",
        style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  //print(data["houseprice"]);
                 Get.to(roomDetails(),
                  arguments: {
                    "extraservices":data["extraservices"],
                    "extraservicescharges":data["extraservicescharges"],
                    "houseprice":data["houseprice"],
                    "id":data["id"]
                  });
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.15,
             //   color: Colors.teal,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Get.width * 0.24,
                        height: Get.height * 0.12,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/home.png"),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Superior Double Room",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.width * 0.04
                            ),),
                            Text("Max : 4 person",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: Get.width * 0.03
                              ),)
                          ],
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("\$20/per night",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: Get.width * 0.03
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
