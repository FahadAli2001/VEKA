import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  void getImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      isImageSizeWithinLimit(File(value!.path)).then((val) {
        if (val == false) {
          Get.snackbar("Error", "Image size should be less than 1MB",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
        } else {
          setState(() {
            imageFile = File(value.path);
          });
        }
      });
    });
  }

  Future<bool> isImageSizeWithinLimit(File imageFile) async {
    const maxSize = 500000; // 2 MB in bytes
    final fileSize = await imageFile.length();

    if (fileSize > maxSize) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (imageFile != null) {
                editProfileController.getAcessToken(image: imageFile);
              } else {
                Get.snackbar("Error", "Please select an image");
              }
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
                        : Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: Image.network(editProfileController
                                                  .image.value !=
                                              ""
                                          ? editProfileController.image.value
                                          : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                                      .image,
                                  fit: BoxFit.scaleDown,
                                ),
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
            // SizedBox(
            //   height: 30,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    );
  }
}
