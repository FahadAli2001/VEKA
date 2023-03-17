import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:veka/car/BuyingCarsDetails/BuyingCarsDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/CarHome/CarHomePageController.dart';
import '../Mybookmark/rents/rentBookmarkController.dart';
import 'package:html/parser.dart';
import '../ReviewSubmission/reviewsubmission.dart';
import '../bookingScreen/bookingScreen.dart';
import '../bookingScreen/bookingScreenController.dart';

class CarHomePage extends StatelessWidget {
  CarHomePage({Key? key}) : super(key: key);

  CarHomePageController car = Get.put(CarHomePageController());

  rentBookmarkController rbmc = Get.put(rentBookmarkController());

  Color color = Colors.grey.shade300;
  var data = Get.arguments;
  bookingScreenController bsc = Get.put(bookingScreenController());

  RxList<dynamic> rxisSelected = [].obs;

  @override
  Widget build(BuildContext context) {
    // rxisSelected.value = RxList.generate(data?["extraservices"].length, (_) => false);
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/Veka-Green.png",
            height: 180,
            width: 150,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white70,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     // Get.to(ChooseOption());
          //   },
          //   icon: Icon(
          //     CupertinoIcons.line_horizontal_3_decrease,
          //     color: Colors.black,
          //     size: Get.height * 0.04,
          //   ),
          // ),
          actions: [
            Padding(
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
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Good Morning,",
                    style: TextStyle(
                        fontSize: Get.height * 0.02, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    hintText: 'Find any car..',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        "Best Cars",
                        style: TextStyle(
                            fontSize: Get.height * 0.02, color: Colors.black),
                      ),
                      Container(
                        width: Get.width * 0.16,
                        height: Get.height * 0.0018,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              //-------
              /*Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: TextField(
                  style: TextStyle(
                    height:  0.5
                  ),
                  decoration: InputDecoration(

                      prefixIcon: Icon(CupertinoIcons.search),
                      prefixIconColor: Colors.grey,
                      hintText: "Find any car",
                      helperStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(

                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true
                  ),
                ),
              ),*/
              //-------------
              FutureBuilder(
                  future: car.allproducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.snackbar("Error", "Something Went Wrong",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.grey);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                      // isLoad.value = true;
                    }
                    /* var description = parse(snapshot.data[index]["short_description"].toString());
                    String parsedstring = description.documentElement!.text;*/
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height * 0.265,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return carCards(
                                snapshot.data![index]["name"].toString(),
                                snapshot.data[index]["images"][0]["src"]
                                    .toString(),
                                snapshot.data[index]["price"].toString(),
                                car.HtmlToText(snapshot.data[index]
                                        ["short_description"]
                                    .toString()),
                                snapshot.data[index]["meta_data"][11]["value"],
                                snapshot.data![index]["meta_data"][10]["value"],
                                snapshot.data![index]["meta_data"][20]["value"],
                                index);
                          },
                        ),
                      ),
                    );
                  }),

              //--------------------------
              Obx(
                () => SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                            width: Get.width * 0.45,
                            height: Get.height * 0.055,
                            child: InkWell(
                              onTap: () {
                                car.rent.value = true;
                                car.buy.value = false;

                                // car.rentProduct();
                              },
                              child: Card(
                                elevation: 5,
                                color: (car.rent.value == false)
                                    ? Colors.white
                                    : car.rentbtn.value,
                                child: Center(
                                  child: Text(
                                    "RENTS",
                                    style: TextStyle(
                                        color: (car.rent.value == false)
                                            ? Colors.black
                                            : car.renttxt.value,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: Get.width * 0.45,
                            height: Get.height * 0.055,
                            child: InkWell(
                              onTap: () {
                                //rent = false;
                                car.rent.value = false;
                                car.buy.value = true;
                                // car.sellProduct();
                              },
                              child: Card(
                                color: (car.buy.value == false)
                                    ? car.buybtn.value
                                    : Colors.black,
                                child: Center(
                                  child: Text(
                                    "BUYINGS",
                                    style: TextStyle(
                                        color: (car.buy.value == false)
                                            ? car.buytxt.value
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: SizedBox(
                  height: Get.height * 0.055,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        width: 80,
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "AUDI",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Card(
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              "LEXUS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "PORSCHE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "BMW",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //--------------------------------
              Obx(
                () => (car.rent.value == true)
                    ? FutureBuilder(
                        future:  car.rentProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("has error");
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            );
                          }
                          return Expanded(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount: snapshot.data!.length,

                              itemBuilder: (BuildContext context, int index) {
                                return product(
                                    car.rentData![index]["images"][0]["src"]
                                        .toString(),
                                    car.rentData![index]["name"].toString(),
                                    car.rentData![index]["price"].toString(),
                                    snapshot.data![index]["short_description"]
                                        .toString(),
                                    snapshot.data![index]["meta_data"][3]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][5]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][11]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][10]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][12]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][20]
                                        ["value"],
                                    snapshot.data![index]["id"],
                                    rbmc,
                                    bsc,
                                    rxisSelected,
                                    color);
                              },

                              // child: ListView.builder(
                              //   itemCount: snapshot.data!.length,
                              //   scrollDirection: Axis.horizontal,
                              //   itemBuilder: (context, index) {
                            ),
                          );
                        },
                      )
                    : //--------------
                    FutureBuilder(
                        future: car.sellProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("has error");
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            );
                          }
                          //
                          //
                          return Expanded(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount: car.selldata!.length, //

                              itemBuilder: (BuildContext context, int index) {
                                return products(
                                    car.selldata[index]["images"][0]["src"]
                                        .toString(),
                                    car.selldata[index]["name"].toString(),
                                    car.selldata[index]["price"].toString(),
                                    snapshot.data![index]["meta_data"][20]
                                        ["value"],
                                    snapshot.data[index]["meta_data"][11]
                                        ["value"],
                                    snapshot.data![index]["meta_data"][10]
                                        ["value"],
                                    snapshot.data[index]["id"]);
                              },
                            ),
                          );
                        },
                      ),
              )
              //--------------------
            ],
          ),
        ));
  }

  Widget RentBuyBtn(Color rentbtn, Color renttxt) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                  width: Get.width * 0.4,
                  height: Get.height * 0.07,
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 5,
                      color: rentbtn,
                      child: Center(
                        child: Text(
                          "RENTS",
                          style: TextStyle(
                              color: renttxt, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: Get.width * 0.4,
                  height: Get.height * 0.07,
                  child: InkWell(
                    onTap: () {
                      //rent = false;
                      rentbtn == Colors.white;
                      renttxt == Colors.black;
                    },
                    child: const Card(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          "BUYINGS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget carCards(String carname, String carimage, carprice, cardescription,
      cardetails, cardetailsinfo, carmoreinfo, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: SizedBox(
        width: Get.width * 0.48,
        height: Get.height * 0.25,
        child: Stack(
          children: [
            SizedBox(
              width: Get.width * 0.46,
              height: Get.height * 0.25,
              child: Card(
                //color: Colors.green,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2,
                        color: index == 0 ? Colors.green : Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      carname,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 80,
              child: SizedBox(
                width: Get.width * 0.3,
                height: Get.height * 0.15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(carimage.toString()),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Positioned(
                top: 180,
                left: 50,
                child: SizedBox(
                    child: InkWell(
                  onTap: () {
                    //print(carmoreinfo);
                    Get.bottomSheet(
                      carDetails(carname, carimage, carprice, cardescription,
                          cardetails, cardetailsinfo, carmoreinfo),
                      isScrollControlled: true,
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              index != 0 ? Colors.black : Colors.transparent),
                      color: index == 0 ? Colors.black : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black,
                              fontSize: 10),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: index == 0 ? Colors.white : Colors.black,
                          size: 10,
                        )
                      ],
                    ),
                  ),
                ))),
          ],
        ),
      ),
    );
  }

  Widget products(carImage, carName, carprice, carspecs, List cardetails,
      List cardetailsinfo, id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          //print(id);
          Get.to(() => const BuyingCarsDetails(), arguments: {
            "carname": carName.toString(),
            "carImage": carImage.toString(),
            "carprice": carprice.toString(),
            "carspecs": carspecs,
            "cardetails": cardetails,
            "cardetailsinfo": cardetailsinfo,
            "id": id.toString()
          });
        },
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              SizedBox(
                height: 20,
                child: Center(
                  child: Text(
                    carName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: Get.width * 0.7,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(carImage.toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 65,
                width: Get.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Text(
                            "Mileage:",
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            "4900 Km",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Location: ",
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Daipro",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Text(
                            "Engine",
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "3.5 Diesel",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Text(
                            "17900",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  "More Details",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget product(
      String carImage,
      String carName,
      String carprice,
      String cardescription,
      List? extraservices,
      List? extraservicesCharges,
      List? cardetail,
      List? cardetailinfo,
      List? cardeatailicon,
      List? carspecs,
      id,
      rentBookmarkController rbmc,
      bookingScreenController bsc,
      List? rxisSelected,
      Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.bottomSheet(
              Container(
                  height: Get.height * 0.9,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                  ),
                  child: FutureBuilder(
                      future: rbmc.getsharekeybyId(false,
                          pid: id.toString(), isWishlist: true),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          );
                        }
                        rxisSelected = RxList.generate(
                            extraservices!.length, (_) => false);
                        return ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(CupertinoIcons.back),
                                    color: Colors.black,
                                  ),
                                  //
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          if (rbmc.wishListId
                                              .containsValue(id)) {
                                            rbmc.removeBookmark(
                                                rbmc.wishListId["itemId"]);
                                          } else {
                                            rbmc.getsharekeybyId(false,
                                                pid: id);
                                          }
                                        },
                                        icon: Icon(Icons.favorite,
                                            color: rbmc.BookmarkId.contains(id)
                                                ? Colors.red
                                                : Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CarouselSlider.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    //color: Colors.orange,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(carImage.toString()),
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover)),
                              ),
                              options: CarouselOptions(
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  //height: Get.height * 0.1,
                                  aspectRatio: 18 / 8,
                                  onPageChanged: (index, reason) {}),
                            ),
                            //-------
                            Container(
                              // color: Colors.pinkAccent,
                              width: Get.width,
                              height: Get.height * 0.1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        carName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: Get.height * 0.02),
                                        softWrap: true,
                                      ),
                                      Text(
                                        "\$${carprice.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: Get.height * 0.02),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //----------------
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  "About",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.height * 0.02),
                                ),
                              ),
                            ),
                            //--------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                //data!["cardescription"].toString()

                                child: Text(
                                  parse(cardescription).documentElement!.text,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: Get.height * 0.02),
                                ),
                                /*Text(  description.toString(),
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: Get.height * 0.02
                        ),
                      ),*/
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text(
                                  "Car Specs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.height * 0.02),
                                ),
                              ),
                            ),
                            //
                            Container(
                              width: Get.width,
                              height: Get.height * 0.09,
                              //color: Colors.red,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var i = 0;
                                      i < carspecs!.length;
                                      i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Card(
                                        elevation: 10,
                                        child: Container(
                                          color: Colors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Center(
                                              child: Text(
                                                carspecs[i].toString(),
                                                softWrap: true,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            ),
                            //
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: Text(
                                  "Car Info",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.height * 0.025),
                                ),
                              ),
                            ),
                            //
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0;
                                          i < cardetail!.length;
                                          i++) ...[
                                        Text(
                                          cardetail[i].toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Get.width * 0.045),
                                        ),
                                      ]
                                    ],
                                  ),
                                  //

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0;
                                          i < cardetailinfo!.length;
                                          i++) ...[
                                        Text(
                                          cardetailinfo[i].toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Get.width * 0.045),
                                        )
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //---
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // print(extraservices);
                                    Get.bottomSheet(
                                        Container(
                                            height: Get.height * 0.9,
                                            width: Get.width,
                                            //  height:  Get.height * 0.9,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(50),
                                                    topLeft:
                                                        Radius.circular(50))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15),
                                                    child: Center(
                                                      child: Text(
                                                        "Booking Form",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Get.width *
                                                                    0.05),
                                                      ),
                                                    ),
                                                  ),
                                                  //
                                                  FutureBuilder(
                                                      future:
                                                          bsc.getdroplocation(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasError) {
                                                          print(snapshot.error
                                                              .toString());
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          );
                                                        }
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      //height: Get.height * 0.35,
                                                                      width: Get
                                                                              .width /
                                                                          2.2,
                                                                      //  color: Colors.orange,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Pick Up Location",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            //
                                                                            FutureBuilder(
                                                                              future: bsc.getpicklocation(),
                                                                              builder: (context, snapshot) {
                                                                                List<String> element = [];
                                                                                for (var i = 0; i < bsc.picklocation.length; i++) {
                                                                                  element.add(bsc.picklocation[i]["title"]['rendered']!.toString());
                                                                                }
                                                                                bsc.pick.value = element[0].toString();
                                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                  return Container();
                                                                                }
                                                                                if (snapshot.hasData == null) {
                                                                                  return Container();
                                                                                }
                                                                                if (snapshot.hasError) {
                                                                                  return Container();
                                                                                }
                                                                                return Obx(
                                                                                  () => Card(
                                                                                    elevation: 2,
                                                                                    child: Container(
                                                                                      color: color,
                                                                                      width: Get.width / 0.2,
                                                                                      height: Get.height * 0.07,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: DropdownButton(
                                                                                            value: bsc.pick.toString(),
                                                                                            icon: const Icon(
                                                                                              Icons.keyboard_arrow_down,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            items: element.map((String items) {
                                                                                              return DropdownMenuItem(
                                                                                                value: items,
                                                                                                child: Text(items),
                                                                                              );
                                                                                            }).toList(),
                                                                                            onChanged: (val) {
                                                                                              bsc.pick.value = val.toString();
                                                                                            }),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            //
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            //
                                                                            Text(
                                                                              "Pick Up Date",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            Card(
                                                                              elevation: 2,
                                                                              child: Container(
                                                                                color: color,
                                                                                width: Get.width / 0.2,
                                                                                height: Get.height * 0.07,
                                                                                child: TimePickerSpinnerPopUp(
                                                                                  mode: CupertinoDatePickerMode.date,
                                                                                  
                                                                                  initTime: bsc.pickupdate.value,
                                                                                  barrierColor: Colors.black12,
                                                                                  onChange: (dateTime) {
                                                                                    bsc.pickupdate.value = dateTime;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            //
                                                                            Text(
                                                                              "Total Person",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            Obx(
                                                                              () => Card(
                                                                                elevation: 2,
                                                                                child: Container(
                                                                                  color: color,
                                                                                  width: Get.width / 0.2,
                                                                                  height: Get.height * 0.07,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: DropdownButton(
                                                                                        // Initial Value
                                                                                        value: bsc.persondropdownvalue.value,
                                                                                        // Down Arrow Icon
                                                                                        icon: const Icon(
                                                                                          Icons.keyboard_arrow_down,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        // Array list of items
                                                                                        items: bsc.persons.map((String items) {
                                                                                          return DropdownMenuItem(
                                                                                            value: items,
                                                                                            child: Text(items),
                                                                                          );
                                                                                        }).toList(),
                                                                                        onChanged: (val) {
                                                                                          bsc.personSelected(val.toString());
                                                                                        }),
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
                                                                      //height: Get.height * 0.36,
                                                                      // color: Colors.green,
                                                                      width: Get
                                                                              .width /
                                                                          2.2,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Drop Of Location",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            FutureBuilder(
                                                                              future: bsc.getdroplocation(),
                                                                              builder: (context, snapshot) {
                                                                                List<String> element = [];
                                                                                for (var i = 0; i < bsc.droplocation!.length; i++) {
                                                                                  element.add(bsc.droplocation![i]["title"]['rendered']!.toString());
                                                                                }
                                                                                bsc.drop.value = element[0].toString();
                                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                  return Container();
                                                                                }
                                                                                if (snapshot.hasData == null) {
                                                                                  return Container();
                                                                                }
                                                                                if (snapshot.hasError) {
                                                                                  return Container();
                                                                                }
                                                                                return Obx(
                                                                                  () => Card(
                                                                                    elevation: 2,
                                                                                    child: Container(
                                                                                      color: color,
                                                                                      width: Get.width / 0.2,
                                                                                      height: Get.height * 0.07,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: DropdownButton(
                                                                                            value: bsc.drop.value.toString(),
                                                                                            icon: const Icon(
                                                                                              Icons.keyboard_arrow_down,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            items: element.map((String items) {
                                                                                              return DropdownMenuItem(
                                                                                                value: items,
                                                                                                child: Text(items),
                                                                                              );
                                                                                            }).toList(),
                                                                                            onChanged: (val) {
                                                                                              bsc.drop.value = val.toString();
                                                                                            }),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            //
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            //
                                                                            Text(
                                                                              "Drop Of Date",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            Card(
                                                                              elevation: 2,
                                                                              child: Container(
                                                                                color: color,
                                                                                width: Get.width / 0.2,
                                                                                height: Get.height * 0.07,
                                                                                child: TimePickerSpinnerPopUp(
                                                                                  mode: CupertinoDatePickerMode.date,
                                                                                  minTime: bsc.dropOfdate.value.add(Duration(days: 2)),
                                                                                  initTime:bsc.dropOfdate.value.add(Duration(days: 2))fa,
                                                                                  barrierColor: Colors.black12,
                                                                                  onChange: (dateTime) {
                                                                                    bsc.dropOfdate.value = dateTime;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            //
                                                                            Text(
                                                                              "Quantity",
                                                                              style: TextStyle(color: Colors.green, fontSize: Get.width * 0.04),
                                                                            ),
                                                                            Card(
                                                                              elevation: 2,
                                                                              child: Obx(
                                                                                () => Container(
                                                                                  color: color,
                                                                                  width: Get.width / 0.2,
                                                                                  height: Get.height * 0.07,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: DropdownButton(
                                                                                        value: bsc.carqntyvalue.value,
                                                                                        icon: const Icon(
                                                                                          Icons.keyboard_arrow_down,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        items: bsc.carqnty.map((String items) {
                                                                                          return DropdownMenuItem(
                                                                                            value: items,
                                                                                            child: Text(items),
                                                                                          );
                                                                                        }).toList(),
                                                                                        onChanged: (val) {
                                                                                          bsc.carqntySelected(val.toString());
                                                                                        }),
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
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "Payment",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            Get.width *
                                                                                0.04),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Obx(
                                                                    () => Card(
                                                                      elevation:
                                                                          2,
                                                                      child:
                                                                          Container(
                                                                        color:
                                                                            color,
                                                                        width: Get.width /
                                                                            2.2,
                                                                        height: Get.height *
                                                                            0.07,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: DropdownButton(
                                                                              value: bsc.paymenttypevalue.value.toString(),
                                                                              icon: const Icon(
                                                                                Icons.keyboard_arrow_down,
                                                                                color: Colors.black,
                                                                              ),
                                                                              items: bsc.paymenttype.map((String items) {
                                                                                return DropdownMenuItem(
                                                                                  value: items,
                                                                                  child: Text(items),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                bsc.paymentTypeSelected(val.toString());
                                                                              }),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              //
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Extra Service",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              Get.width * 0.05),
                                                                    ),
                                                                    Text(
                                                                      "Charges",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              Get.width * 0.05),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              //extraservices!.length
                                                              for (var i = 0;
                                                                  i <
                                                                      extraservices
                                                                          .length;
                                                                  i++) ...[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child:
                                                                      Container(
                                                                    width: Get
                                                                        .width,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              Get.width * 0.5,
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                ListTile(
                                                                              title: Text(
                                                                                extraservices[i].toString(),
                                                                                style: TextStyle(fontSize: Get.width * 0.04),
                                                                              ),
                                                                              leading: Checkbox(
                                                                                  value: rxisSelected![i],
                                                                                  onChanged: (val) {
                                                                                    print(val);
                                                                                    rxisSelected![i] = val!;
                                                                                    /*print(val);
                                                                                                                                                            bsc.handleRadioValueChanged(val);*/
                                                                                  }),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "\$${extraservicesCharges![i].toString()}",
                                                                          style:
                                                                              TextStyle(fontSize: Get.width * 0.04),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                            ],
                                                          ),
                                                        );
                                                      }),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // print( bsc.totalcarPrice(rxisSelected.toList(), data["extraservicescharges"], data["carprice"]));
                                                        //bsc.pricewidget(rxisSelected.toList(), data!["extraservicescharges"], data!["extraservices"]);
                                                        //print(data["extraservices"]);
                                                        Get.to(
                                                            const reviewsubmission(),
                                                            arguments: {
                                                              "carimage": carImage
                                                                  .toString(),
                                                              "carname": carName
                                                                  .toString(),
                                                              "carprice": carprice
                                                                  .toString(),
                                                              "carqnty": bsc
                                                                  .carqntyvalue
                                                                  .value,
                                                              "totalprice": bsc
                                                                  .totalcarPrice(
                                                                      rxisSelected!
                                                                          .toList(),
                                                                      extraservicesCharges!,
                                                                      carprice),
                                                              "extraservices":
                                                                  extraservices,
                                                              "charges": bsc.pricewidget(
                                                                  rxisSelected,
                                                                  extraservicesCharges,
                                                                  extraservices),
                                                              "id": id,
                                                              "rxisSelected":
                                                                  rxisSelected
                                                            });
                                                      },
                                                      child: Container(
                                                        width: Get.width / 1.4,
                                                        height:
                                                            Get.height * 0.06,
                                                        color: Colors.green,
                                                        child: Center(
                                                          child: Text(
                                                            "Next",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.05),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        isScrollControlled: true);

                                    //print(data["extraservices"][1].toString());
                                    // Get.to(bookingScreen(), arguments: {
                                    //   "carimage": carImage.toString(),
                                    //   "carname": carName.toString(),
                                    //   "carprice": carprice.toString(),
                                    //   "extraservices":extraservices,
                                    //   "extraservicescharges": extraservicesCharges,
                                    //   "id": id
                                    // });
                                  },
                                  child: Container(
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.06,
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        "Go To Book",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: Get.width * 0.04),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
              isScrollControlled: true);
          // print(extraservices[1]);
          // Get.to(const RentCarDetails(), arguments: {
          //   "carname": carName,
          //   "carimage": carImage,
          //   "carprice": carprice,
          //   "cardescription": cardescription,
          //   "extraservices": extraservices,
          //   "extraservicescharges": extraservicesCharges,
          //   "cardetail": cardetail,
          //   "cardetailinfo": cardetailinfo,
          //   "cardetailicon": cardeatailicon,
          //   "carspecs": carspecs,
          //   "id": id
          // });
        },
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Container(
                width: Get.width * 0.7,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(carImage.toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: Get.width,
                child: Column(
                  children: [
                    Text(
                      carName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const Text(
                      "0 reviews",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.calendar_month,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "2015",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.calendar_month,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Petrol",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.flutter_dash,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Tiptronic",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.flutter_dash,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "2500 cc",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rentCardetail(carname, carimage, carprice, cardescription) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: Get.width,
        height: Get.height * 0.9,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: ListView(
          children: [
            SizedBox(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            carname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.height * 0.02),
                          ),
                          FavoriteButton(
                            iconSize: 40,
                            isFavorite: true, valueChanged: () {},
                            // iconDisabledColor: Colors.white,
                            // valueChanged: (_isFavorite) {
                            //   print('Is Favorite : $_isFavorite');
                            // },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "\$${carprice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: Get.height * 0.02),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //----------------

            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                width: Get.width,
                decoration: BoxDecoration(
                    //color: Colors.orange,
                    image: DecorationImage(
                        image: NetworkImage(carimage),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover)),
                child: const Text(
                  "1",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  //height: Get.height * 0.1,
                  aspectRatio: 18 / 8,
                  onPageChanged: (index, reason) {}),
            ),
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  cardescription,
                  style: TextStyle(
                      color: Colors.grey.shade700, fontSize: Get.height * 0.02),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            //
            SizedBox(
              width: Get.width,
              height: Get.height * 0.2,
              //color: Colors.red,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Card(
                      elevation: 7,
                      child: SizedBox(
                        //   color: Colors.blue,
                        width: Get.width * 0.3,
                        height: Get.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Max Power",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02),
                              ),
                              Text(
                                "350",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.03),
                              ),
                              Text(
                                "hp",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.2,
                // color: Colors.pink,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: const ListTile(
                            title: Text("2015"),
                            leading: Icon(
                              CupertinoIcons.calendar,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: const ListTile(
                            title: Text("Petrol"),
                            leading: Icon(
                              Icons.local_gas_station,
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: const ListTile(
                            title: Text("2"),
                            leading: Icon(
                              CupertinoIcons.person_2_fill,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: const ListTile(
                            title: Text("2500"),
                            leading: Icon(
                              Icons.flash_on,
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(const bookingScreen(), arguments: {
                    "carimage": carimage.toString(),
                    "carname": carname.toString(),
                    "carprice": carprice.toString()
                  });
                },
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.06,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.05),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget carDetails(carname, carimage, carprice, cardescription, cardetail,
      cardetailinfo, List carmoreinfo) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: Get.width,
        height: Get.height * 0.9,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: ListView(
          children: [
            SizedBox(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            carname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.height * 0.02),
                          ),
                          /*LikeButton(
                            size: 30,
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                CupertinoIcons.heart,
                                color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                              );
                            },
                          ),*/
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "\$${carprice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: Get.height * 0.02),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //----------------

            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                width: Get.width,
                decoration: BoxDecoration(
                    //color: Colors.orange,
                    image: DecorationImage(
                        image: NetworkImage(carimage),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover)),
                child: const Text(
                  "1",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  //height: Get.height * 0.1,
                  aspectRatio: 18 / 8,
                  onPageChanged: (index, reason) {}),
            ),
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            /*
            var description = parse(data["cardescription"]);
            String parsedstring = description.documentElement!.text;
            */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  cardescription,
                  style: TextStyle(
                      color: Colors.grey.shade700, fontSize: Get.height * 0.02),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            //
            /* Row(
              children: [
                for(var i = 0 ; i <carmoreinfo.length ; i++)...[
                  Text(carmoreinfo[i],
                    softWrap:true,style: TextStyle(
                        color: Colors.black
                    ),)
                ]
              ],
            ),*/
            SizedBox(
              width: Get.width,
              height: Get.height * 0.05,
              //color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < carmoreinfo.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              carmoreinfo[i],
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
            //
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < cardetail.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cardetail[i],
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]
                    ],
                  ),
                  //

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < cardetailinfo.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cardetailinfo[i],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.04),
                          ),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
