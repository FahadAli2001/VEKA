import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/house/EditProfile/House_Edit_Profile_Screen.dart';
import 'package:veka/house/RENT/rentHome/rentHomeController.dart';
import '../../BUYING/home/homeScreen.dart';
import '../../Bookmarks/rents/rent_bookmark_controller.dart';
import '../HouseDetails/detailScreen.dart';

class RentHome extends StatelessWidget {
  const RentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentHomeController rhc = Get.put(rentHomeController());
    RealStateRentBookmarkController realStateRentcontroller =
        Get.put(RealStateRentBookmarkController());
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/Veka-Red.png",
          height: 180,
          width: 150,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => HouseEditProfileScreen(isRent: true));
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 20),
                child: Column(
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      radius: 18,
                    ),
                    // SizedBox(height: 5,),
                    Text(
                      "Hi, Belly",
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ],
                )),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white70,
        // leading: IconButton(
        //   onPressed: () {
        //     Get.to(const homeScreen());
        //   },
        //   icon: Icon(
        //     CupertinoIcons.line_horizontal_3_decrease,
        //     color: Colors.black,
        //     size: Get.height * 0.04,
        //   ),
        // ),
      ),
      //--------
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: FutureBuilder(
          future: rhc.rentProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Get.snackbar("Error", snapshot.error.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
            }
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
            return ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: realStateRentcontroller.getsharekeybyId(false,
                        pid: snapshot.data[index]["id"].toString(),
                        isWishlist: true),
                    builder: (context, data) {
                      if (!data.hasData) {
                        return index == 0
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            //print(snapshot.data![index]["meta_data"][12]["value"]);
                            // print(snapshot.data[index]["meta_data"][18]["value"][0].toString());
                            Get.to(() => const detailScreen(), arguments: {
                              "totalrooms": snapshot.data![index]["meta_data"]
                                      [18]["value"][0]
                                  .toString(),
                              "houseimage": snapshot.data![index]["images"][0]
                                  ["src"],
                              "housename":
                                  snapshot.data[index]["name"].toString(),
                              "houseprice": snapshot.data![index]["price"],
                              "description": snapshot.data[index]
                                  ["description"],
                              "location": snapshot.data![index]["meta_data"][18]
                                  ["value"][1],
                              "facilities": snapshot.data![index]["meta_data"]
                                  [22]["value"],
                              "extraservices": snapshot.data![index]
                                  ["meta_data"][9]["value"],
                              "extraservicescharges": snapshot.data![index]
                                  ["meta_data"][12]["value"],
                              "id": snapshot.data![index]["id"]
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            width: Get.width,
                            height: Get.height * 0.35,
                            //color: Colors.orange,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height,
                                  width: Get.width / 2.8,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[index]["images"][0]["src"]),
                                          fit: BoxFit.fill)),
                                ),
                                //----
                                SizedBox(
                                  height: Get.height,
                                  width: Get.width * 0.53,
                                  //color: Colors.pink,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  snapshot.data[index]["name"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    //fontSize: Get.width * 0.05
                                                  ),
                                                  softWrap: true,
                                                ),
                                              ),
                                              FavoriteButton(
                                                isFavorite:
                                                    realStateRentcontroller
                                                            .wishListId.values
                                                            .contains(snapshot
                                                                    .data[index]
                                                                ["id"])
                                                        ? true
                                                        : false,
                                                iconSize: 30,
                                                valueChanged: (value) {
                                                  if (value) {
                                                    realStateRentcontroller
                                                        .getsharekeybyId(true,
                                                            pid: snapshot
                                                                .data[index]
                                                                    ["id"]
                                                                .toString());
                                                  } else {
                                                    realStateRentcontroller
                                                        .removeBookmark(
                                                            realStateRentcontroller
                                                                    .wishListId[
                                                                "itemId"]);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.star_fill,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                        ["average_rating"]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                        //---------
                                        /* Padding(
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
                                        ),*/
                                        //------------

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\$${snapshot.data[index]["price"]}",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: Get.width * 0.045,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //--
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.location_solid,
                                                color: Colors.black,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data![index]
                                                          ["meta_data"][18]
                                                      ["value"][1],
                                                  softWrap: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        //------------
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            );
          },
        ),
      )),
    );
  }
}
