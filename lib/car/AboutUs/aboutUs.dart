import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("About Us",
       style: TextStyle(
         color: Colors.black
       ),),
       centerTitle: true,
       elevation: 0,
       backgroundColor: Colors.white70,
       leading: IconButton(
         onPressed: (){
           Get.back();
         },
         icon: Icon(CupertinoIcons.back,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                    child: Text("The reason that your About Us statement on job postings is so important is that some candidates first experience your jobs through a job posting/ad (e.g. from a job board, Google, a shared link, etc.). They don’t always visit your career site first (or at all).",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Get.width * 0.04
                    ),)),
                SizedBox(height: 5,),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("The reason that your About Us statement on job postings is so important is that some candidates first experience your jobs through a job posting/ad (e.g. from a job board, Google, a shared link, etc.). They don’t always visit your career site first (or at all).",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: Get.width * 0.04
                      ),)),
                //---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.black,)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Get In Touch",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      Expanded(child: Divider(color: Colors.black,)),
                    ],
                  ),
                ),
                //-------------
                SizedBox(
                  width: Get.width,
                  child: ListTile(
                    leading: Icon(CupertinoIcons.location_solid,
                    color: Colors.black,
                    size: Get.width * 0.06,),
                    title: Text("Karachi"),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: ListTile(
                    leading: Icon(CupertinoIcons.phone_fill,
                      color: Colors.black,
                      size: Get.width * 0.06,),
                    title: Text("+92 111 111 118"),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: ListTile(
                    leading: Icon(Icons.email,
                      color: Colors.black,
                      size: Get.width * 0.06,),
                    title: Text("Veka@gmail.com"),
                  ),
                ),
                //-------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.black,)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Working Hours",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      Expanded(child: Divider(color: Colors.black,)),
                    ],
                  ),
                ),
                //-------------
                SizedBox(
                  width: Get.width,
                  child: ListTile(

                    title: Text("Sales Department",
                    style: TextStyle(
                      color: Colors.green
                    ),),
                    subtitle: Text("Monday to Friday"),
                  ),
                ),
                //--------
                SizedBox(
                  width: Get.width,
                  child: ListTile(

                    title: Text("Service Department",
                      style: TextStyle(
                          color: Colors.green
                      ),),
                    subtitle: Text("Monday to Friday"),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
