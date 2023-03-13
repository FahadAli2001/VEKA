import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/orderDetails/buying/buyingdetails.dart';

import '../../login/LoginController.dart';
import '../BuyingMeeting/buyingMeeting.dart';
import '../houseHome/sellHomeController.dart';

class buyhouseDetails extends StatelessWidget {
  const buyhouseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sellHomeController shc = Get.put(sellHomeController());
    loginController lgc = Get.put(loginController());
    final PageController _pageController = PageController();

    var data = Get.arguments;
    var description = parse(data["description"]);
    String parsedstring = description.documentElement!.text;

    // String desc = parsedstring.trim();
    // log(parsedstring);

    var des =
        """[log] Across from Frere Hall and Park, the 5-star Karachi House offers modern and luxurious rooms with a flat-screen cable TV. It features 3 dining options, spa and outdoor swimming pool.
      The air-conditioned and fully carpeted rooms each have their own private bathroom, which include free toiletries, shower, hairdryer and slippers. An electric kettle and minibar can be found in each room.
      KarachiHouse is 302 m from the Hockey Club of Pakistan and less than half a kilometer from Holy Trinity Cathedral. National Museum of Pakistan is 2.4 km away. Karachi Jinnah International Airport is 14.5 km from the hotel.
      Guests have access to a 24-hour business center while those staying on the executive level can use a private lounge. In the hotel, guests will find a drugstore, florist and currency exchange. Laundry and dry cleaning services are available for an extra fee.
      Nadia Coffee Shop -Coffee House features a menu with European and Pakistani cuisine. Dumpukht Restaurant offers barbecue dishes and live cooking demonstrations. Order Chinese dishes at Suzie Wong Restaurant.
      
      
      Couples in particular like the location – they rated it 8.2 for a two-person trip.
      Most popular facilities
      Outdoor swimming pool
      Airport shuttle (free)
      Room service
      Fitness center
      Restaurant
      Non-smoking rooms
      Free parking
      Bar
      Good Breakfast""";
    //log(des);
    var pid = data["id"];
    //print(parsedstring);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "buy",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.09,
        // color: Colors.teal,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: InkWell(
              onTap: () {
                //print(data["id"].toString());
                Get.to(buyingMeeting(), arguments: {"id": data!["id"]});
                print(data["id"]);
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: Get.width,
                height: Get.height,
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: Get.width * 0.05),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  // color: Colors.teal,
                  //
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (_, index) => Container(
                      width: Get.width * 2,
                      height: Get.height,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(data["houseimage"].toString()),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 3,
                    effect: ExpandingDotsEffect(
                        dotHeight: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black), // your preferred effect
                  ),
                ),

                //--------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        data!["housename"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          //fontSize: Get.width * 0.06
                        ),
                        maxLines: 1,
                      ),
                      //
                      Text(
                        "\$${data!['houseprice']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: Get.width * 0.04),
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["location"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.03),
                      ),
                      //
                      /* Text("\$${data['houseprice']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: Get.width * 0.04
                        ),),*/
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.bathtub_rounded,
                              color: Colors.red,
                              size: 25,
                            ),
                            Text("4")
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.bed_sharp,
                              color: Colors.red,
                              size: 25,
                            ),
                            Text(data["totalrooms"].toString())
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.scale,
                              color: Colors.red,
                              size: 25,
                            ),
                            Text("1000sqY")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //----
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Get.width * 0.05),
                  ),
                ),
                //

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: ReadMoreText(
                        parsedstring,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: Get.width * 0.036),
                        trimLines: 2,
                        colorClickableText: Colors.red,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Facilities",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.05),
                    ),
                  ),
                ),
                //
                for (var i = 0; i < data["facilities"].length; i++) ...[
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          data["facilities"][i],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: Get.width * 0.04),
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
