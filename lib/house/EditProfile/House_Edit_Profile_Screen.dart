import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../BUYING/dashboard/houseDashboard.dart';
import '../RENT/dashboard/dashboard.dart';
import 'home_edit_profile_controller.dart';

// ignore: must_be_immutable
class HouseEditProfileScreen extends StatefulWidget {
  final bool isRent;
  const HouseEditProfileScreen({super.key, required this.isRent});

  @override
  State<HouseEditProfileScreen> createState() => _HouseEditProfileScreenState();
}

class _HouseEditProfileScreenState extends State<HouseEditProfileScreen> {

  HomeEditProfileController homeEditProfileController =
      Get.put(HomeEditProfileController());
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  void getImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        imageFile = File(value!.path);
      });
    });
  }

  RxBool isUpdated = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CupertinoButton(
            color: Colors.red,
            child: const Text(
              "Save",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // isUpdated.value = true;
              homeEditProfileController.getAcessToken();
              // isUpdated.value = false;
            }),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        leading: IconButton(
            onPressed: () {
              widget.isRent == true
                  ? Get.off(() => const dashboard(
                        isRent: true,
                      ))
                  : Get.off(() => const houseDashboard(
                        isRent: false,
                      ));
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
              //  color: Colors.amber,
              width: Get.width * 0.5,
              height: Get.height * 0.2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 35),
                    child: imageFile != null
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: Image.file(imageFile!).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: Image.network(
                                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                                    .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: const CircleAvatar(
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
            // const SizedBox(
            //   height: 30,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.firstName,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.lastName,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.address,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.country,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.city,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: homeEditProfileController.contact,
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
    );
  }
}
