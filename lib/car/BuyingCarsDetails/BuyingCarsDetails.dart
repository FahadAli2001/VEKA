import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../ReviewSubmission/reviewsubmission.dart';

class BuyingCarsDetails extends StatelessWidget {
  const BuyingCarsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectionbox = Colors.grey;
    var data=Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: Text(data["carname"],
        style: TextStyle(
          color: Colors.black
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StarButton(
              isStarred: false,
              // iconDisabledColor: Colors.white,
              valueChanged: (_isStarred) {
                print('Is Starred : $_isStarred');
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.08,
      //  color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  //data["carname"],data["carImage"],data["carprice"]
                  Get.to(reviewsubmission(),arguments: {
                    "carname":data["carname"].toString(),
                    "carimage":data["carImage"].toString(),
                    "carprice":data["carprice"].toString()
                  });
                },
                child: Container(
                  width: Get.width * 0.4,
                  height: Get.height * 0.8,
                  color: Colors.green,
                  child: Center(
                    child: Text("Buy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.04
                    ),),
                  ),
                ),
              ),
              Container(
                width: Get.width * 0.44,
                height: Get.height * 0.8,
                color: Colors.black,
                child: Center(
                  child: Text("Contact Seller",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: Get.width * 0.04
                    ),),
                ),
              ),

            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height ,
           // color: Colors.blue,

          ),
          //-----------------
          Container(
            width: Get.width,
            height: Get.height  * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(data["carImage"]),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover
                )
            ),
           // color: Colors.orange,
          ),
          //------------------------
          Positioned(
            top:170,
            child: Container(

              width: Get.width,
              height: Get.height *0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)
                  )
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                    child: Container(
                      width: Get.width,
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data["carname"],
                                  style: TextStyle(
                                      fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.bold
                                  ),),
                                Text("\$ ${data["carprice"]}",
                                  style: TextStyle(
                                    color: Colors.green,
                                      fontSize: Get.width * 0.04
                                  ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Karachi",
                                  style: TextStyle(
                                      fontSize: Get.width * 0.04
                                  ),),
                                Text("\$900|MONTH",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: Get.width * 0.04
                                  ),),
                              ],
                            ),
                          ),

                          //
                        ],
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.2,
                      //color: Colors.red,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
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
                                  padding: const EdgeInsets.all(8.0),
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
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Details",
                        style: TextStyle(
                          color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.05
                        ),),
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Interior colors",
                              style: TextStyle(
                                  color: Colors.grey,

                                  fontSize: Get.width * 0.04
                              ),),
                            Text("Grey",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.04
                              ),),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Exterior colors",
                              style: TextStyle(
                                  color: Colors.grey,

                                  fontSize: Get.width * 0.04
                              ),),
                            Text("Predawn White",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.04
                              ),),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),

                      ],
                    ),
                  ),
                  //

                ],
              ),
            ),
          )

        ],
      ),
    );
  }

}
