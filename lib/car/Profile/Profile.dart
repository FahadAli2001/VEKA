import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'ProfileController.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    profileController pc = Get.put(profileController());
    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.08,
        //  color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: (){
              pc.signOut();
            },
            child: Container(
              width: Get.width * 0.4,
              height: Get.height * 0.8,
              color: Colors.green,
              child: Center(
                child: Text("LogOut",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.width * 0.04
                  ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
