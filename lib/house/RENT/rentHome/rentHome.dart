import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/house/RENT/rentHome/rentHomeController.dart';

import '../../../ChooseOption.dart';
import '../../BUYING/HouseDetails/houseDetails.dart';
import '../HouseDetails/detailScreen.dart';

class rentHome extends StatelessWidget {
  const rentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentHomeController rhc = Get.put(rentHomeController());

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
          child:FutureBuilder(
            future: rhc.rentProduct(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                Get.snackbar("Error", snapshot.error.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey
                );
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                }
              }
              if(snapshot.data == null){
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                       // print(snapshot.data[index]["meta_data"][18]["value"][0].toString());
                        Get.to(Get.to(detailScreen(),
                        arguments: {
                          "totalrooms":snapshot.data[index]["meta_data"][18]["value"][0].toString(),
                          "houseimage":snapshot.data[index]["images"][0]["src"],
                          "housename":snapshot.data[index]["name"].toString(),
                          "houseprice":snapshot.data[index]["price"],
                          "description":snapshot.data[index]["description"]
                        }));
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
                                  color: Colors.grey.shade200,
                                  image: DecorationImage(
                                      image:NetworkImage(snapshot.data[index]["images"][0]["src"]),
                                      fit: BoxFit.fill
                                  )
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
                                          Expanded(
                                            child: AutoSizeText(snapshot.data[index]["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  //fontSize: Get.width * 0.05
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          FavoriteButton(
                                              iconSize: 30,
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
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            //allowHalfRating: true,
                                            itemCount: 5,
                                            //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              size: 15,
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
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
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
                                              child: Text("\$${snapshot.data[index]["price"]}",
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
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
      )),
    );
  }
}
