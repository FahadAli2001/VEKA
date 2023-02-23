import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/Mybookmark/rents/rentBookmarkController.dart';

class rent extends StatelessWidget {
  const rent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bookmark = true.obs;
    var list;
    rentBookmarkController rbmc = Get.put(rentBookmarkController());


    return Scaffold(

      body: FutureBuilder(
        future: rbmc.fetchBookmarks(),
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
         
          return ListView.builder(
            itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.11,
                  //color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index]["image"].toString()),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text(snapshot.data![index]["name"].toString()),
                          subtitle: Text(snapshot.data![index]["price"].toString(),
                            style: TextStyle(
                                color: Colors.green
                            ),),
                        ),
                      ),
                      Obx(
                            ()=> IconButton(
                          onPressed: (){

                          },
                          icon:Icon(Icons.bookmark),
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
