import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/ChooseOption.dart';
import 'package:favorite_button/favorite_button.dart';

import '../../RENT/HouseDetails/detailScreen.dart';
import '../HouseDetails/houseDetails.dart';

class houseHome extends StatelessWidget {
  const houseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
        child:ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 2,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(Get.to(houseDetails()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    )
                  ),
                  width: Get.width,
                  height: Get.height * 0.35,
                  //color: Colors.orange,
                  child: Row(

                    children: [
                      Container(
                        height:Get.height ,
                        width: Get.width / 2.8,

                        decoration: BoxDecoration(
                            color: Colors.green,
                          image: DecorationImage(image: AssetImage("assets/home.png"),
                          fit: BoxFit.fill
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: Get.height * 0.04,
                                color: Colors.green,
                                child: Center(
                                  child: Text("BreakFast included",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //----
                      Container(
                        height: Get.height,
                        width: Get.width * 0.53,
                        //color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Luxury Hotel",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Get.width * 0.05
                                      ),),
                                    FavoriteButton(
                                      iconSize: 35,
                                        valueChanged: (){})
                                  ],
                                ),
                              ),
                              //---------
                          Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: RatingBar.builder(
                                  initialRating: 1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  //allowHalfRating: true,
                                  itemCount: 5,
                                  //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ),
                          ),
                              //------------
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.location_solid,color: Colors.black,),
                                    Text("Bykoz - 9 miles from center")
                                  ],
                                ),
                              ),
                              //------------
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text("price for 7 night 2 adults",
                                  style: TextStyle(
                                    fontSize: Get.width * 0.04,
                                    color: Colors.black
                                  ),),
                                ),
                              ),
                              //
                              Align(
                                alignment: Alignment.topRight,
                                child: Text("\$1300",
                                  style: TextStyle(
                                      color: Colors.red,
                                    fontSize: Get.width * 0.04,
                                  ),),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      )),
    );
  }
}
