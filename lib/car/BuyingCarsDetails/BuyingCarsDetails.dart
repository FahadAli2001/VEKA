import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Mybookmark/buying/BuyingBookmarkController.dart';
import '../Mybookmark/rents/rentBookmarkController.dart';
import '../SignIn/SignInController.dart';
import '../buyReviewSubmission/buyRevuewSubmission.dart';

class BuyingCarsDetails extends StatelessWidget {
  BuyingCarsDetails({Key? key}) : super(key: key);

  SignInController sic = Get.put(SignInController());
  rentBookmarkController rbmc = Get.put(rentBookmarkController());
  var data = Get.arguments;
  BuyingBookmarkController bbmc = Get.put(BuyingBookmarkController());

  @override
  Widget build(BuildContext context) {
    var pid = data["id"].toString();
    return FutureBuilder(
      future: rbmc.getsharekeybyId(true, pid: pid.toString(), isWishlist: true),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white70,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
            ),
            title: Text(
              data["carname"],
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      if (rbmc.wishListId.containsValue(pid)) {
                        rbmc.removeBookmark(rbmc.wishListId["itemId"]);
                      } else {
                        rbmc.getsharekeybyId(false, pid: pid);
                      }
                    },
                    icon: Icon(Icons.favorite,
                        color: rbmc.BookmarkId.contains(pid)
                            ? Colors.red
                            : Colors.grey),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: SizedBox(
            width: Get.width,
            height: Get.height * 0.08,
            //  color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      //data["carname"],data["carImage"],data["carprice"]
                      Get.to(const buyReviewSubmission(), arguments: {
                        "carname": data["carname"].toString(),
                        "carimage": data["carImage"].toString(),
                        "carprice": data["carprice"].toString(),
                        "id": data["id"]
                      });
                    },
                    child: Container(
                      width: Get.width * 0.4,
                      height: Get.height * 0.8,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "Buy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.width * 0.04),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.44,
                    height: Get.height * 0.8,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Contact Seller",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: Get.width * 0.04),
                      ),
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
                height: Get.height,
                // color: Colors.blue,
              ),
              //-----------------
              Container(
                width: Get.width,
                height: Get.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data["carImage"]),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover)),
                // color: Colors.orange,
              ),
              //------------------------
              Positioned(
                top: 170,
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.9,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Container(
                          width: Get.width,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data["carname"],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.04,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$ ${data["carprice"]}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: Get.width * 0.04),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    // Text(
                                    //   "Karachi",
                                    //   style: TextStyle(fontSize: Get.width * 0.04),
                                    // ),
                                    /*Text("\$900|MONTH",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: Get.width * 0.04
                                        ),),*/
                                  ],
                                ),
                              ),

                              //
                            ],
                          ),
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Car Specs",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.08,
                          //color: Colors.red,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i = 0;
                                  i < data["carspecs"].length;
                                  i++) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    color: Colors.grey.shade300,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Center(
                                        child: Text(
                                          data["carspecs"][i],
                                          softWrap: true,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Car Info",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width * 0.05),
                          ),
                        ),
                      ),
                      //
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < data["cardetails"].length;
                                      i++) ...[
                                    Text(
                                      data["cardetails"][i],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Get.width * 0.04),
                                    ),
                                  ],
                                ],
                              ),
                              //

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < data["cardetailsinfo"].length;
                                      i++) ...[
                                    Text(
                                      data["cardetailsinfo"][i],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.04),
                                    ),
                                  ],
                                ],
                              )
                            ],
                          )),
                      //
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
