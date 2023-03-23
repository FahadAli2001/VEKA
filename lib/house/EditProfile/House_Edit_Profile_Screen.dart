import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BUYING/dashboard/houseDashboard.dart';
import '../RENT/dashboard/dashboard.dart';
import 'home_edit_profile_controller.dart';

class HouseEditProfileScreen extends StatelessWidget {
  bool isRent;
  HouseEditProfileScreen({super.key, required this.isRent});

  HomeEditProfileController homeEditProfileController =
      Get.put(HomeEditProfileController());

  RxBool isUpdated = false.obs;

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
                print("tap");
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
                this.isRent == true
                    ? Get.off(() => dashboard(
                          isRent: true,
                        ))
                    : Get.off(() => houseDashboard(
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
              // SizedBox(
              //   //    color: Colors.amber,
              //   width: Get.width * 0.5,
              //   height: Get.height * 0.2,
              //   child: Stack(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 20, horizontal: 35),
              //         child: CircleAvatar(
              //           radius: 60,
              //           backgroundColor: Colors.grey.shade300,
              //           child: const Icon(
              //             Icons.person,
              //             color: Colors.green,
              //             size: 50,
              //           ),
              //         ),
              //       ),
              //       const Positioned(
              //         top: 90,
              //         left: 120,
              //         child: CircleAvatar(
              //           backgroundColor: Colors.white,
              //           child: Icon(
              //             Icons.edit,
              //             color: Colors.green,
              //             size: 30,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      ),
    );
  }
}
