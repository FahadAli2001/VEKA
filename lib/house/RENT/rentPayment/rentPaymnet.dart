import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../ReviewSubmission/RentReviewSubmission.dart';

class rentPayment extends StatelessWidget {
  const rentPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Step>step=[
      Step(

        title: Text(""), content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.28,
              decoration: BoxDecoration(
                  //color: Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.red
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Adults",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.width * 0.06
                            ),),
                            //
                            Text("Age 18+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03
                              ),),

                          ],
                        ),
                        //------

                        //-----
                      Container(
                        child: Row(
                           children: [  Container(
                             width: 70,
                             height: 30,
                             color: Colors.grey,
                             child: Center(
                               child: Icon(Icons.remove,color: Colors.black,),
                             ),
                           ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                               child: Text("01",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black,
                                     fontSize: Get.width * 0.05
                                 ),),
                             ),
                             Container(
                               width: 70,
                               height: 30,
                               color: Colors.grey,
                               child: Center(
                                 child: Icon(Icons.add,color: Colors.black,),
                               ),
                             ),
                           ],
                        ),
                      ),],
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Childrens",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.width * 0.06
                            ),),
                            //
                            Text("Age 2-18",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03
                              ),),

                          ],
                        ),
                        //------

                        //-----
                       Container(
                         child: Row(
                           children: [
                             Container(
                               width: 70,
                               height: 30,
                               color: Colors.grey,
                               child: Center(
                                 child: Icon(Icons.remove,color: Colors.black,),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                               child: Text("01",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black,
                                     fontSize: Get.width * 0.05
                                 ),),
                             ),
                             Container(
                               width: 70,
                               height: 30,
                               color: Colors.grey,
                               child: Center(
                                 child: Icon(Icons.add,color: Colors.black,),
                               ),
                             ),
                           ],
                         ),
                       )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Infants",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.06
                              ),),
                            //
                            Text("Age 0-2",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03
                              ),),

                          ],
                        ),
                        //------

                        //-----
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 30,
                                color: Colors.grey,
                                child: Center(
                                  child: Icon(Icons.remove,color: Colors.black,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text("01",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Get.width * 0.05
                                  ),),
                              ),
                              Container(
                                width: 70,
                                height: 30,
                                color: Colors.grey,
                                child: Center(
                                  child: Icon(Icons.add,color: Colors.black,),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("PAYMENT METHOD",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Get.width * 0.06
                ),),
            ),
            //----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5),
              child: Container(
                height: Get.height * 0.06,
                width: Get.width,
                //color: Colors.red,
                child: Row(
                  children: [
                    Radio(value: 0,
                        groupValue: null, onChanged: null),
                    Text("Cash on delivery",
                      style: TextStyle(
                          fontSize: Get.width * 0.04
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5),
              child: Container(
                height: Get.height * 0.06,
                width: Get.width,
                //color: Colors.red,
                child: Row(
                  children: [
                    Radio(value: 0,
                        groupValue: null, onChanged: null),
                    Text("Visa ***********",
                      style: TextStyle(
                          fontSize: Get.width * 0.04
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //-------

          ],
        ),
      ),),
      Step(title: Text(""), content:Text(""
      ),
          isActive: true),
      Step(title: Text(""), content: Text(""),),

    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: GestureDetector(
          onTap: (){
            Get.to(RetReviewSubmission());
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey
                )
            ),
            child: Center(
              child: Text("NEXT"),
            ),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
            accentColor: Colors.red,
            primaryColor: Colors.red,
            colorScheme: ColorScheme.light(
                primary: Colors.red
            )
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: step,
          controlsBuilder: (context, controller) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );


  }
}
