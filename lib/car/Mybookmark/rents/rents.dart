import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class rent extends StatelessWidget {
  const rent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bookmark = true.obs;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: ListView.builder(
            itemCount: 4,
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
                            backgroundImage: AssetImage("assets/car.png"),
                            radius: 30,
                            backgroundColor: Colors.black54,
                          ),
                          title: Text("AUDI A3"),
                          subtitle: Text("\$450",
                          style: TextStyle(
                            color: Colors.green
                          ),),
                        ),
                      ),
                      Obx(
                            ()=> IconButton(
                          onPressed: (){
                            if(bookmark.value == true){
                              bookmark.value = false;
                            }else{
                              bookmark.value = true;
                            }
                          },
                          icon:Icon(Icons.bookmark),

                          color: (bookmark.value == true)?Colors.green:Colors.grey,),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
