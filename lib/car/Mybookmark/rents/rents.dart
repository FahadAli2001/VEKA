

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

    final Stream<QuerySnapshot> _usersStream  = FirebaseFirestore.instance
        .collection('rentalCar-bookmarks')
        .doc(sic.userId)
        .collection('productIds').snapshots();

    return Scaffold(
      body: StreamBuilder(
        stream:  _usersStream,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(child: Text("some thing went wrong"));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data == null){
            return Center(child: Text("no data"));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
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
                            backgroundImage: NetworkImage(data[index]["image"].toString()),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text(data[index]["name"].toString()),
                          subtitle: Text(data[index]["price"].toString(),
                            style: TextStyle(
                                color: Colors.green
                            ),),
                        ),
                      ),
                      Obx(
                            ()=> IconButton(
                          onPressed: (){

                          },
                          icon:Icon(Icons.favorite),
                          color: (bookmark.value == true)?Colors.green:Colors.grey,),
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
