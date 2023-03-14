import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/Mybookmark/rents/rentBookmarkController.dart';

import '../../SignIn/SignInController.dart';

class rent extends StatelessWidget {
  const rent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController sic = Get.put(SignInController());
    var bookmark = true.obs;
    rentBookmarkController rbmc = Get.put(rentBookmarkController());



    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        //rbmc.getAllData();
        print(rbmc.allBookmark());
      }),
      body: FutureBuilder(
        future:  rbmc.allBookmark(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data == null){
            return Center(child:Text("No Bookmark"));
          }
          var data = snapshot.data!;
          return ListView.builder(
            itemCount:rbmc.products.length,
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500)
                  ),
                  width: Get.width,
                  //height: Get.height * 0.11,
                  //color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(rbmc.products[index]["images"][0]["src"].toString()),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text(rbmc.products[index]["name"].toString()),
                          subtitle: Text(rbmc.products[index]["price"].toString(),
                            style: TextStyle(
                                color: Colors.green
                            ),),
                        ),
                      ),

                             IconButton(
                          onPressed: (){
                          //  rbmc.toggleBookmark(data[index]["id"].toString(), data[index]["name"].toString(),data[index]["price"].toString(),data[index]["image"].toString());
                          },
                          icon:Icon(Icons.favorite),
                          color: Colors.red,

                      )
                    ],
                  ),
                ),
              );
              });
        },
      ),
    );
  }
}
