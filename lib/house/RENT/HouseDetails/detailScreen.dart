import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../AvailableRooms/availableRooms.dart';
import '../rentStepper/rentStepper.dart';

class detailScreen extends StatelessWidget {
  const detailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
    PageController();

    var data = Get.arguments;

    var description = parse(data["description"]);
    String parsedstring = description.documentElement!.text;


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
        title: Text("Rent Details",
          style: TextStyle(
              color: Colors.black
          ),),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.09,
        // color: Colors.teal,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            child: InkWell(
              onTap: (){
                //print(data["houseprice"]);
                Get.to(rentStepper(),
                arguments: {
                  "houseprice":data["houseprice"],
                  "extraservices":data["extraservices"],
                  "extraservicescharges":data["extraservicescharges"],
                  "id":data["id"]
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                width: Get.width,
                height: Get.height,
                child: Center(
                  child: Text("Available Dates",
                    style: TextStyle(
                        fontSize: Get.width * 0.04
                    ),),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
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
                            image:NetworkImage(data["houseimage"].toString()),
                            fit: BoxFit.cover),
                      ),

                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black), // your preferred effect

                ),

                //--------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(data["housename"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                        ),
                      maxLines: 1,),
                      //
                      Text("\$${data["houseprice"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: Get.width * 0.04
                        ),),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data["location"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.03
                        ),),
                      //
                      Text("\$${data["houseprice"]}/month",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: Get.width * 0.04
                        ),),
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
                            Icon(Icons.bathtub_rounded,color: Colors.red,size: 25,),
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
                            Icon(Icons.bed_sharp,color: Colors.red,size: 25,),
                            Text(data["totalrooms"])
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
                            Icon(Icons.scale,color: Colors.red,size: 25,),
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
                  child: Text("Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Get.width * 0.05
                    ),),
                ),
                //

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child:ReadMoreText(
                      parsedstring,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: Get.width * 0.036
                      ),
                    trimLines: 2,
                    colorClickableText: Colors.red,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                    color: Colors.red),
                  )
                ),

                //----
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Facilities",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.05
                      ),),
                  ),
                ),
                //
                for(var i = 0 ; i < data["facilities"].length ; i++)...[
                  Row(
                    children: [
                      Icon(CupertinoIcons.check_mark,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(data["facilities"][i],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: Get.width * 0.04
                          ),),
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
