import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:like_button/like_button.dart';
import 'package:veka/car/BuyingCarsDetails/BuyingCarsDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/ChooseOption.dart';
import 'package:veka/car/CarHome/CarHomePageController.dart';

import '../RentCarDetails/RentCarDetails.dart';
import '../bookingScreen/bookingScreen.dart';



class CarHomePage extends StatelessWidget {
  const CarHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarHomePageController car = Get.put(CarHomePageController());


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

        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Have a good day",
                    style: TextStyle(
                        fontSize: Get.height * 0.02,
                        color: Colors.grey
                    ),),
                ),
              ),
              //-------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: TextField(
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
              ),
              //-------------
              FutureBuilder(
                  future: car.allproducts(),
                  builder:(context,snapshot) {
                    if (snapshot.hasError) {
                      Get.snackbar("Error", "Something Went Wrong",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.grey
                      );
                    }
                    else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );

                      // isLoad.value = true;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.35,
                        //color:Colors.orange ,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return carCards(snapshot.data[index]["name"].toString(),
                                snapshot.data[index]["images"][0]["src"].toString(),
                                snapshot.data[index]["price"].toString(),
                                snapshot.data[index]["short_description"].toString(),
                              snapshot.data[index]["meta_data"][11]["value"],
                              snapshot.data![index]["meta_data"][10]["value"],
                              snapshot.data![index]["meta_data"][20]["value"]
                            );
                          },

                        ),
                      ),
                    );
                  }),
              //--------------------------
              Obx(()=>
                  Container(
                    width: Get.width ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(

                              width: Get.width * 0.4,
                              height: Get.height * 0.07,
                              child: InkWell(
                                onTap: (){
                                  car.rent.value = true;
                                  // rent.value = false;
                                  //
                                  car.buy.value = false;
                                  // rent.value = true;
                                  car.rentProduct();
                                  print("rent");
                                },
                                child: Card(

                                  elevation: 5,
                                  color: (car.rent.value == false)?Colors.white:car.rentbtn.value,
                                  child: Center(
                                    child: Text("RENTS",
                                      style: TextStyle(
                                          color: (car.rent.value==false)?Colors.black:car.renttxt.value,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: Get.width * 0.4,
                              height: Get.height * 0.07,
                              child:InkWell(
                                onTap: (){
                                  //rent = false;
                                  car.rent.value = false;
                                  car.buy.value =true;
                                  car.sellProduct();
                                  print("buy");

                                },
                                child: Card(
                                  color: (car.buy.value == false)?car.buybtn.value:Colors.black,
                                  child: Center(
                                    child: Text("BUYINGS",
                                      style: TextStyle(
                                          color: (car.buy.value==false)?car.buytxt.value:Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),),

                                  ),
                                ),
                              )
                          ),
                        )
                      ],
                    ),

                  ),
              ),
              //--------------------------------
              Obx(() => (car.rent.value==true)?
              FutureBuilder(
                future: car.rentProduct(),
                builder: (context,snapshot){
                  if(snapshot.hasError){
                    return Text("has error");
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  }
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.4,
                        child: ListView.builder(
                          itemCount:  snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return product(car.rentData[index]["images"][0]["src"].toString(),
                                car.rentData[index]["name"].toString(),
                                car.rentData[index]["price"].toString(),
                                snapshot.data[index]["short_description"].toString(),
                              snapshot.data[index]["meta_data"][3]["value"],
                              snapshot.data[index]["meta_data"][5]["value"],
                              snapshot.data[index]["meta_data"][11]["value"],
                              snapshot.data![index]["meta_data"][10]["value"],
                              snapshot.data![index]["meta_data"][12]["value"],
                                snapshot.data![index]["meta_data"][20]["value"]


                            );
                          },
                        ),
                      ),
                    );
                },
              )://--------------
              FutureBuilder(
                future: car.sellProduct(),
                builder: (context,snapshot){
                  if(snapshot.hasError){
                    return Text("has error");
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  }
                  //
                  //
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.4,
                        child: ListView.builder(
                          itemCount:  snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return  products(car.selldata[index]["images"][0]["src"].toString(),
                                car.selldata[index]["name"].toString(),
                                car.selldata[index]["price"].toString(),
                                snapshot.data![index]["meta_data"][20]["value"],
                              snapshot.data[index]["meta_data"][11]["value"],
                              snapshot.data![index]["meta_data"][10]["value"],
                              snapshot.data[index]["id"]
                            );
                          },
                        ),
                      ),
                    );
                },
              ),
              )
              //--------------------


            ],

          ),
        )
    );
  }
  Widget RentBuyBtn(Color rentbtn,Color renttxt){
    return
      Obx(()=>
          Container(
            width: Get.width ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(

                      width: Get.width * 0.4,
                      height: Get.height * 0.07,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Card(

                          elevation: 5,
                          color: rentbtn,
                          child: Center(
                            child: Text("RENTS",
                              style: TextStyle(
                                  color: renttxt,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: Get.width * 0.4,
                      height: Get.height * 0.07,
                      child:InkWell(
                        onTap: (){
                          //rent = false;
                          rentbtn == Colors.white;
                          renttxt == Colors.black;
                          print("tappp");

                        },
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Text("BUYINGS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),

                          ),
                        ),
                      )
                  ),
                )
              ],
            ),

          ),
      );
  }

  Widget carCards(String carname,String carimage,carprice,cardescription,cardetails,cardetailsinfo, carmoreinfo){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width * 0.49,
        child: Stack(
          children: [
            SizedBox(
              width: Get.width * 0.43,
              height: Get.height * 0.28,
              child: Card(
                //color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      carname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Get.width * 0.04
                      ),

                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 80,
              child: Container(
                width: Get.width * 0.3,
                height: Get.height * 0.20,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(carimage.toString()),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
            ),
            Positioned(
                top: 200,
                left: 15,
                child: SizedBox(
                    child:InkWell(
                      onTap: (){
                        //print(carmoreinfo);
                        Get.bottomSheet(
                          carDetails(carname,carimage,carprice,cardescription,
                              cardetails,cardetailsinfo, carmoreinfo),
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 50,
                        color: Colors.black,
                        child: Center(
                          child: Text("Details",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ),
                    )
                ))
          ],
        ),
      ),
    );
  }

  Widget products(carImage,carName,carprice,carspecs, cardetails, cardetailsinfo,id){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          //print(id);
          Get.to(()=>BuyingCarsDetails(),arguments: {
            "carname":carName.toString(),
            "carImage":carImage.toString(),
            "carprice":carprice.toString(),
            "carspecs":carspecs,
            "cardetails":cardetails,
            "cardetailsinfo":cardetailsinfo,
            "id":id.toString()
          });
        },
        child: Card(
          elevation: 5,
          child: Container(
            width: Get.width * 0.7,
            height: 600,
            decoration: BoxDecoration(
              //  color: Colors.orange,
              image: DecorationImage(
                image: NetworkImage(carImage.toString()),
                fit: BoxFit.cover,
              ),

              borderRadius:
              BorderRadius.all(Radius.circular(5),),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(carName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.05
                  ),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget product(carImage,carName,carprice,cardescription,List extraservices,List extraservicesCharges,
      List cardetail,List cardetailinfo,List cardeatailicon,carspecs){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
         // print(extraservices[1]);
          Get.to(RentCarDetails(),
          arguments: {
            "carname":carName,
            "carimage":carImage,
            "carprice":carprice,
            "cardescription":cardescription,
            "extraservices":extraservices,
            "extraservicescharges":extraservicesCharges,
            "cardetail":cardetail,
            "cardetailinfo":cardetailinfo,
            "cardetailicon":cardeatailicon,
            "carspecs":carspecs
          });
        },
        child: Card(
          elevation: 5,
          child: Container(
            width: Get.width * 0.7,
            height: 600,
            decoration: BoxDecoration(
              //  color: Colors.orange,
              image: DecorationImage(
                image: NetworkImage(carImage.toString()),
                fit: BoxFit.cover,
              ),

              borderRadius:
              BorderRadius.all(Radius.circular(5),),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(carName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.05
                  ),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rentCardetail(carname,carimage,carprice,cardescription){
    return  GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        width: Get.width,
        height:Get.height * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
            )
        ),
        child: ListView(
          children: [
            Container(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                child: Padding(padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(carname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.height * 0.02
                            ),),
                          LikeButton(
                            size: 30,
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                CupertinoIcons.heart,
                                color: isLiked ? Colors.deepPurpleAccent : Colors.grey,

                              );
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("\$${carprice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: Get.height * 0.02
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //----------------

            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      //color: Colors.orange,
                        image: DecorationImage(
                            image: NetworkImage(carimage),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover
                        )
                    ),
                    child: Text("1",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ), options:  CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                //height: Get.height * 0.1,
                aspectRatio: 18/8,
                onPageChanged: (index, reason) {

                }),
            ),
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(cardescription,
                  style: TextStyle(

                      color: Colors.grey.shade700,
                      fontSize: Get.height * 0.02
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            //
            Container(
              width: Get.width,
              height: Get.height * 0.2,
              //color: Colors.red,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
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
                          padding: const EdgeInsets.all(8),
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: Container(
                width: Get.width,
                height: Get.height * 0.2,
                // color: Colors.pink,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width:Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2015"),
                            leading: Icon(CupertinoIcons.calendar,
                              color: Colors.green,),
                          ),
                        ),
                        SizedBox(
                          width:Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("Petrol"),
                            leading: Icon(Icons.local_gas_station,
                              color: Colors.green,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width:Get.width * 0.4,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2"),
                            leading: Icon(CupertinoIcons.person_2_fill,
                              color: Colors.green,),
                          ),
                        ),
                        SizedBox(
                          width:Get.width * 0.5,
                          height: Get.height * 0.1,
                          child: ListTile(
                            title: Text("2500"),
                            leading: Icon(Icons.flash_on,
                              color: Colors.green,),
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
                onTap: (){

                  Get.to(bookingScreen(),arguments:
                  {"carimage": carimage.toString(),
                  "carname":carname.toString(),
                  "carprice":carprice.toString()}
                  );
                },
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.06,
                  color: Colors.green,
                  child: Center(
                    child: Text("Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Get.width * 0.05
                      ),),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget carDetails(carname,carimage,carprice,cardescription,cardetail,cardetailinfo,List carmoreinfo){
    return  GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        width: Get.width,
        height:Get.height * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
            )
        ),
        child: ListView(
          children: [
            Container(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                child: Padding(padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(carname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Get.height * 0.02
                            ),),
                          LikeButton(
                            size: 30,
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                CupertinoIcons.heart,
                                color: isLiked ? Colors.deepPurpleAccent : Colors.grey,

                              );
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("\$${carprice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: Get.height * 0.02
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //----------------

            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      //color: Colors.orange,
                        image: DecorationImage(
                            image: NetworkImage(carimage),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover
                        )
                    ),
                    child: Text("1",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ), options:  CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                //height: Get.height * 0.1,
                aspectRatio: 18/8,
                onPageChanged: (index, reason) {

                }),
            ),
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(cardescription,
                  style: TextStyle(

                      color: Colors.grey.shade700,
                      fontSize: Get.height * 0.02
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
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
           Container(
              width: Get.width,
              height: Get.height * 0.05,
              //color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(var i = 0 ; i <carmoreinfo.length ; i++)...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(carmoreinfo[i],
                              softWrap:true,style: TextStyle(
                                  color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),),
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
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var i = 0 ; i < data["cardetailicon"].length ; i++) ... [
                            Icon(
                            data["cardetailicon"][i],
                              size: 32.0,
                              color: Colors.green,
                            )
                      ]

                    ],
                  ),*/
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var i = 0 ; i < cardetail.length ; i++)...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cardetail[i],
                            style: TextStyle(
                                color: Colors.green.shade900,
                                fontSize: Get.width * 0.045
                            ),),
                        ),

                      ]
                    ],
                  ),
                  //

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var i = 0 ; i < cardetailinfo.length ; i++)...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cardetailinfo[i],
                            style: TextStyle(
                                color: Colors.green.shade800,
                                fontSize: Get.width * 0.045
                            ),),
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


