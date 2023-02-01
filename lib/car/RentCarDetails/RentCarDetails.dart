import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';

import '../bookingScreen/bookingScreen.dart';

class RentCarDetails extends StatelessWidget {
  const RentCarDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){Get.back();},
            icon: Icon(CupertinoIcons.back),
        color: Colors.black,),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LikeButton(
              size: 30,
              likeBuilder: (bool isLiked) {
                return Icon(
                  CupertinoIcons.heart,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.grey,

                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
           //print(data["extraservices"][1].toString());
            Get.to(bookingScreen(),arguments:
            {"carimage": data!["carimage"].toString(),
              "carname":data!["carname"].toString(),
              "carprice":data!["carprice"].toString(),
              "extraservices":data!["extraservices"],
              "extraservicescharges":data!["extraservicescharges"]
            }
            );
          },
          child: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.06,
            color: Colors.green,
            child: Center(
              child: Text("Next",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Get.width * 0.05
                ),),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView(
          children: [


            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      //color: Colors.orange,
                        image: DecorationImage(
                            image: NetworkImage(data!["carimage"].toString()),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover
                        )
                    ),

                  ), options:  CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                //height: Get.height * 0.1,
                aspectRatio: 18/8,
                onPageChanged: (index, reason) {

                }),
            ),
            //-------
            Container(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                child: Padding(padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(data["carname"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.height * 0.02
                          ),
                          softWrap: true,
                        ),
                      ),
                      Text("\$${data["carprice"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: Get.height * 0.02
                        ),),
                    ],
                  ),
                ),
              ),
            ),
            //----------------
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Text("About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.02
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(data["cardescription"],
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: Get.height * 0.02
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.02
                  ),),
              ),
            ),
            //
            Container(
              width: Get.width,
              height: Get.height * 0.2,
              //color: Colors.red,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder:(context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Card(
                      elevation: 7,
                      child: Container(
                        //   color: Colors.blue,
                        width: Get.width * 0.3,
                        height: Get.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Max Power",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height *0.02
                                ),),
                              Text("350",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height *0.03
                                ),
                              ),
                              Text("hp",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height *0.02
                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } ,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Text("Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.02
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Container(
                width: Get.width,
                height: Get.height * 0.2,
                // color: Colors.pink,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width:Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2015"),
                            leading: Icon(CupertinoIcons.calendar,
                              color: Colors.green,),
                          ),
                        ),
                        SizedBox(
                          width:Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("Petrol"),
                            leading: Icon(Icons.local_gas_station,
                              color: Colors.green,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width:Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2"),
                            leading: Icon(CupertinoIcons.person_2_fill,
                              color: Colors.green,),
                          ),
                        ),
                        SizedBox(
                          width:Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2500"),
                            leading: Icon(Icons.flash_on,
                              color: Colors.green,),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            //


          ],
        ),
      ),
    );
  }
}
