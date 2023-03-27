import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/house/BUYING/houseHome/sellHomeController.dart';
import 'package:veka/house/EditProfile/house_edit_profile_screen.dart';
import '../../Bookmarks/rents/rent_bookmark_controller.dart';
import '../../login/LoginController.dart';
import '../HouseDetails/houseDetails.dart';
import '../home/homeScreen.dart';

class houseHome extends StatelessWidget {
  houseHome({Key? key}) : super(key: key);

  sellHomeController shc = Get.put(sellHomeController());
  loginController lgc = Get.put(loginController());
  RealStateRentBookmarkController realStateRentcontroller =
      Get.put(RealStateRentBookmarkController());

  @override
  Widget build(BuildContext context) {
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
              Get.to(() => const HouseEditProfileScreen(isRent: false));
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
      ),
      //--------
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: FutureBuilder(
          future: shc.buyProduct(),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // var pid = snapshot.data![index]["id"].toString();
                // var name = snapshot.data[index]["name"].toString();
                // var price = snapshot.data[index]["price"].toString();
                // var image = snapshot.data[index]["images"][0]["src"].toString();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(Get.to(const buyhouseDetails(), arguments: {
                        "totalrooms": snapshot.data[index]["attributes"][0]
                                ["options"][0]
                            .toString(),
                        "housename": snapshot.data[index]["name"].toString(),
                        "houseimage":
                            snapshot.data[index]["images"][0]["src"].toString(),
                        "houseprice": snapshot.data[index]["price"].toString(),
                        "description":
                            snapshot.data[index]["description"].toString(),
                        "facilities": snapshot.data![index]["meta_data"][22]
                            ["value"],
                        "location": snapshot.data![index]["attributes"][1]
                                ["options"][0]
                            .toString(),
                        "id": snapshot.data![index]["id"].toString()
                      }));
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      width: Get.width,
                      height: Get.height * 0.35,
                      //color: Colors.orange,
                      child: Row(
                        children: [
                          Container(
                            height: Get.height,
                            width: Get.width / 2.8,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data[index]
                                            ["images"][0]["src"]
                                        .toString()),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                          ),
                                        ),
                                        //
                                        FavoriteButton(
                                          isFavorite: realStateRentcontroller
                                                  .wishListId.values
                                                  .contains(snapshot.data[index]
                                                      ["id"])
                                              ? true
                                              : false,
                                          iconSize: 30,
                                          valueChanged: (value) {
                                            if (value) {
                                              realStateRentcontroller
                                                  .getsharekeybyId(true,
                                                      pid: snapshot.data[index]
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
                                  //---------
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.star_fill,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          snapshot.data[index]["average_rating"]
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.red),
                                        )
                                      ],
                                    ),
                                  )
                                  /* Padding(
                                   padding: const EdgeInsets.only(right: 1),
                                   child: Align(
                                     alignment: Alignment.topLeft,
                                     child: Container(
                                       child: RatingBar.builder(
                                         initialRating: 0,
                                         minRating: 0,
                                         direction: Axis.horizontal,
                                         //allowHalfRating: true,
                                         itemCount: 5,
                                         //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                         itemBuilder: (context, _) => Icon(
                                           Icons.star,
                                           size: 20,
                                           color: Colors.amber,
                                         ), onRatingUpdate: (double value) {  },
                                       ),
                                     ),
                                   ),
                                 ),*/
                                  //
                                  ,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "\$${snapshot.data[index]["price"].toString()}",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: Get.width * 0.045,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //------------
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.location_solid,
                                            color: Colors.black,
                                          ),
                                          Text(snapshot.data![index]
                                                  ["attributes"][1]["options"]
                                                  [0]
                                              .toString())
                                        ],
                                      ),
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
      )),
    );
  }
}
