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
                  Get.bottomSheet(
                    BookingForm(selectionbox,data["carname"],data["carImage"],data["carprice"]),
                    isScrollControlled: true,
                  );
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
  BookingForm(color,carname,carimage,carprice){
    return Container(
      width: Get.width,
      height: Get.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50)
        )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("BOOKING FORM",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: Get.width * 0.07
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.36,
                  width: Get.width / 2,
                 // color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pick Up Location",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: Get.width * 0.04
                        ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Set location"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(height: 5,),
                        //
                        Text("Pick Up Date",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Get.width * 0.04
                          ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(height: 5,),
                        //
                        Text("Total Person",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Get.width * 0.04
                          ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //-----
                Container(
                  height: Get.height * 0.36,
                 // color: Colors.green,
                  width: Get.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Drop Of Location",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Get.width * 0.04
                          ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Set location"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(height: 5,),
                        //
                        Text("Drop Of Date",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Get.width * 0.04
                          ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(height: 5,),
                        //
                        Text("Quantity",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Get.width * 0.04
                          ),),
                        Card(
                          elevation: 2,
                          child: Container(
                            color: color,
                            width: Get.width / 0.2,
                            height: Get.height * 0.07,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Payment",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: Get.width * 0.04
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                elevation: 2,
                child: Container(
                  color: color,
                  width: Get.width / 2.2,
                  height: Get.height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cash On Delivery"),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Container(
              width: Get.width,
              height: Get.height * 0.25,
              color: Colors.grey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Extra Service",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: Get.width * 0.05
                        ),),
                        Text("Charges",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: Get.width * 0.05
                          ),)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: ListTile(
                          title: Text("Baby seat",
                            style: TextStyle(
                                fontSize: Get.width * 0.04
                            ),
                          ),
                          leading:Radio(value: 0,
                              groupValue: null, onChanged: null),
                        ),
                      ),
                      Text("\$10.0/Total",
                      style: TextStyle(
                      fontSize: Get.width * 0.04
                      ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8
              ),
              child: GestureDetector(
                onTap: (){
                  Get.to(reviewsubmission(),arguments: {
                    "carname":carname.toString(),
                    "carimage":carimage.toString(),
                    "carprice":carprice.toString()
                  });
                },
                child: Container(
                  width: Get.width /1.5,
                  height: Get.height * 0.05,
                  color: Colors.green,
                  child: Center(

                    child:
                    Text("Next",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.05
                    ),),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
