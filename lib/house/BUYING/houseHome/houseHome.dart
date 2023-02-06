import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/ChooseOption.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:veka/house/BUYING/houseHome/sellHomeController.dart';
import 'package:veka/house/RENT/rentHome/rentHome.dart';

import '../../RENT/HouseDetails/detailScreen.dart';
import '../../RENT/rentHome/rentHomeController.dart';
import '../HouseDetails/houseDetails.dart';

class houseHome extends StatelessWidget {
  const houseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    sellHomeController shc = Get.put(sellHomeController());
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
       child: FutureBuilder(
         future: shc.buyProduct(),
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
           if(snapshot.data ==null){
             return Center(
               child: CircularProgressIndicator(
                 color: Colors.grey,
               ) ,
             );
           }
           //shc.buyproducts?.length
           return ListView.builder(
             itemCount:snapshot.data!.length ,
             itemBuilder: (context,index){
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                   onTap: (){
                    // print(snapshot.data![index]["id"].toString());
                     //print("rooms " + snapshot.data[index]["attributes"][0]["options"][0].toString());
                     //print("tapppp");
                     Get.to(Get.to(buyhouseDetails(),
                     arguments: {
                       "totalrooms":snapshot.data[index]["attributes"][0]["options"][0].toString(),
                       "housename":snapshot.data[index]["name"].toString(),
                       "houseimage": snapshot.data[index]["images"][0]["src"].toString(),
                       "houseprice":snapshot.data[index]["price"].toString(),
                       "description":snapshot.data[index]["description"].toString(),
                       "facilities":snapshot.data![index]["meta_data"][22]["value"],
                       "location":snapshot.data![index]["attributes"][1]["options"][0].toString(),
                       "id":snapshot.data![index]["id"].toString()
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
                               color: Colors.grey.shade300,
                               image: DecorationImage(image: NetworkImage(
                                 snapshot!.data[index]["images"][0]["src"].toString()
                               ),
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
                                           ),),
                                       ),
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
                                 //
                                 Align(
                                   alignment: Alignment.topLeft,
                                   child: Text("\$${snapshot.data[index]["price"].toString()}",
                                     style: TextStyle(
                                       color: Colors.red,
                                       fontSize: Get.width * 0.045,
                                     ),),
                                 ),
                                 //------------
                                 Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 15),
                                   child: Row(
                                     children: [
                                       Icon(CupertinoIcons.location_solid,color: Colors.black,),
                                       Text(snapshot.data![index]["attributes"][1]["options"][0].toString())
                                     ],
                                   ),
                                 ),
                                 //------------
                                /* Padding(
                                   padding: const EdgeInsets.only(top: 25),
                                   child: Align(
                                     alignment: Alignment.topRight,
                                     child: Text("price for 7 night 2 adults",
                                       style: TextStyle(
                                           fontSize: Get.width * 0.04,
                                           color: Colors.black
                                       ),),
                                   ),
                                 ),*/
                                 //

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
      )
      ),
    );
  }
}
