import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../ChooseOption.dart';
import '../HouseDetails/detailScreen.dart';

class rentHome extends StatelessWidget {
  const rentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var apartment_btn = true.obs;
    var land_btn = false.obs;
    var flats_btn = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text("VEKA",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: (){
            Get.to(ChooseOption());
          },
          icon: Icon(CupertinoIcons.line_horizontal_3_decrease,
            color: Colors.black,
            size: Get.height * 0.04,
          ),
        ),
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
      ),
      //--------
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Have a good day",
                    style: TextStyle(
                        fontSize: Get.height * 0.02,
                        color: Colors.grey
                    ),),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search),
                      prefixIconColor: Colors.redAccent,
                      hintText: "Find any house",
                      helperStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(

                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true
                  ),
                ),
              ),
              //

              Align(
                alignment: Alignment.topLeft,
                child: Text("Discover",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.05
                  ),),
              ),
              //-----
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                child: Obx(
                  ()=> Container(
                    width: Get.width,
                    height: Get.height * 0.08,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              apartment_btn.value = true;
                              land_btn.value = false;
                              flats_btn.value = false;
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.height * 0.07,
                              color: (apartment_btn.value == true)?Colors.black:Colors.grey.shade300,
                              child: Center(

                                child: Text("Apartments",
                                  style: TextStyle(
                                      color: (apartment_btn.value == true)?Colors.white:Colors.black,
                                  ),),
                              ),
                            ),
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            ()=> GestureDetector(
                              onTap: (){
                                apartment_btn.value = false;
                                land_btn.value = true;
                                flats_btn.value = false;
                              },
                              child: Container(
                                width: Get.width * 0.25,
                                height: Get.height * 0.07,
                                color:(land_btn.value == true)?Colors.black:Colors.grey.shade300,
                                child: Center(
                                  child: Text("Land",
                                    style: TextStyle(
                                        color: (land_btn.value == true)?Colors.white:Colors.black,
                                    ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                              ()=> GestureDetector(
                              onTap: (){
                                apartment_btn.value = false;
                                land_btn.value = false;
                                flats_btn.value = true;
                              },
                              child: Container(
                                width: Get.width * 0.25,
                                height: Get.height * 0.07,
                                color: (flats_btn.value == true)?Colors.black:Colors.grey.shade300,
                                child: Center(
                                  child: Text("Flats",
                                    style: TextStyle(
                                        color:(flats_btn.value == true)?Colors.white:Colors.black,
                                    ),),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //---
              Container(
                  width: Get.width,
                  height: Get.height * 0.35,
                  // color: Colors.black,
                  child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Get.to(detailScreen());
                          },
                          child: Container(

                            width: Get.width * 0.5,
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.grey
                                )
                              // color: Colors.teal,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)
                                      ),
                                      //color: Colors.orange,
                                      image: DecorationImage(
                                          image: AssetImage("assets/home.png"),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Ibn e Manshion",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Get.width * 0.045
                                    ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Details will be upload here",
                                    style: TextStyle(

                                        color: Colors.grey,
                                        fontSize: Get.width * 0.038
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
