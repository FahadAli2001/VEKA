import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../ReviewSubmission/reviewsubmission.dart';
import 'bookingScreenController.dart';


class bookingScreen extends StatelessWidget {
  const bookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    var data = Get.arguments;
    bookingScreenController bsc = Get.put(bookingScreenController());

    RxList<dynamic> rxisSelected=[].obs;
    rxisSelected.value = RxList.generate(data["extraservices"].length, (_) => false);

    var date = DateTime
        .now()
        .obs;




    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(CupertinoIcons.back,
              color: Colors.black,),
          ),

          centerTitle: true,
          title: Text("Booking Form",
            style: TextStyle(
                color: Colors.black
            ),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

            bsc.pricewidget(rxisSelected, data!["extraservicescharges"], data!["extraservices"]);

           // print(bsc.checkboxes.length);

          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              bsc.pricewidget(rxisSelected.toList(), data!["extraservicescharges"], data!["extraservices"]);
              //print(data["extraservices"]);
              Get.to(reviewsubmission(),
                  arguments: {
                    "carimage": data["carimage"].toString(),
                    "carname": data["carname"].toString(),
                    "carprice": data["carprice"].toString(),
                    "carqnty": bsc.carqntyvalue.value,
                    "totalprice": bsc.totalcarPrice(rxisSelected.toList(), data["extraservicescharges"], data["carprice"]),
                    "extraservices":data["extraservices"],
                    "charges":bsc.checkboxes
                  });

            },
            child: Container(
              width: Get.width / 1.4,
              height: Get.height * 0.06,
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

        body: SingleChildScrollView(
          child: Column(
              children: [

          Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.35,
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
                          child: TimePickerSpinnerPopUp(
                            mode: CupertinoDatePickerMode.date,
                            initTime: date.value,
                            minTime: DateTime.now().subtract(const Duration(
                                days: 10)),
                            maxTime: DateTime.now().add(const Duration(
                                days: 10)),
                            barrierColor: Colors.black12,
                            //Barrier Color when pop up show
                            onChange: (dateTime) {
                              // Implement your logic with select dateTime
                              date.value = dateTime;
                            },

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
                      Obx(
                            () =>
                            Card(
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
                                        color: Colors.black,),

                                      // Array list of items
                                      items: bsc.persons.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (val) {
                                        bsc.personSelected(val.toString());
                                      }
                                  ),
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
                          child: TimePickerSpinnerPopUp(
                            mode: CupertinoDatePickerMode.date,
                            initTime: date.value,
                            minTime: DateTime.now().subtract(const Duration(
                                days: 10)),
                            maxTime: DateTime.now().add(const Duration(
                                days: 10)),
                            barrierColor: Colors.black12,
                            //Barrier Color when pop up show
                            onChange: (dateTime) {
                              // Implement your logic with select dateTime
                              date.value = dateTime;
                            },

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
                        child: Obx(
                              () =>
                              Container(
                                color: color,
                                width: Get.width / 0.2,
                                height: Get.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(

                                      value: bsc.carqntyvalue.value,

                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,),

                                      items: bsc.carqnty.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        bsc.carqntySelected(val.toString());
                                      }
                                  ),
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
            child: Obx(
                  () =>
                  Card(
                    elevation: 2,
                    child: Container(
                      color: color,
                      width: Get.width / 2.2,
                      height: Get.height * 0.07,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(

                            value: bsc.paymenttypevalue.value,

                            icon: const Icon(
                              Icons.keyboard_arrow_down, color: Colors.black,),

                            items: bsc.paymenttype.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              bsc.paymentTypeSelected(val.toString());
                            }
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Extra Service",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Get.width * 0.05
                ),),
              Text("Charges",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Get.width * 0.05
                ),)
            ],
          ),
        ),
        //
                for(var i = 0 ; i < data["extraservices"].length;i++)...[
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15),
                     child: Container(
                       width: Get.width,
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Obx(
                                  ()=> ListTile(
                                title: Text(data["extraservices"][i],
                                  style: TextStyle(
                                      fontSize: Get.width * 0.04
                                  ),
                                ),
                                leading:Checkbox(
                                    value:rxisSelected[i],
                                    onChanged:(val){
                                     // print(val);
                                      rxisSelected[i] = val!;
                                      /*print(val);
                                      bsc.handleRadioValueChanged(val);*/
                                    }
                                ),
                              ),
                            ),
                          ),
                          Text("\$${data["extraservicescharges"][i].toString()}",
                            style: TextStyle(
                                fontSize: Get.width * 0.04
                            ),
                          )
                        ],
                  ),
                     ),
                   ),
                ]
    ],
    ),
    ),
    );
  }
}
