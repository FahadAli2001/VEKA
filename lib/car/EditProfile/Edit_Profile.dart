import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Dashboard/dashboardScreen.dart';
import 'Edit_Profile_Controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: CupertinoButton(
              color: Colors.green,
              child: const Text(
                "Save",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                editProfileController.getAcessToken(true);
              }),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white12,
          leading: IconButton(
              onPressed: () {
                Get.off(() => const DashboardScreen());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.06),
                  ),
                ),
              ),
              SizedBox(
                //    color: Colors.amber,
                width: Get.width * 0.5,
                height: Get.height * 0.2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 35),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        editProfileController.getAcessToken(false);
                      },
                      child: const Positioned(
                        top: 90,
                        left: 120,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.firstName,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "First Name",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.lastName,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Last Name",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.address,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Address",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.country,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Country",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.city,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "City",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: editProfileController.contact,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Contact",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
