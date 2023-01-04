import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../SignIn/SignInScreen.dart';
import '../SignUp/SignUp.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        body: Column(
          children: <Widget>[

            // construct the profile details widget here
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/car.png"),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: AssetImage("assets/Veka-Green.png",
                      ),
                    )),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.08
                      ),),
                  ),
                  //
                  Container(

                    height: Get.height * 0.12,
                   // color: Colors.red,
                  ),
                ],
              ),
            ),

            // the tab bar with two items
            SizedBox(
              height:50,
              child:  TabBar(
                indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text("Sign In",
                        style: TextStyle(
                            color: Colors.black
                        ),),
                    ),
                    Tab(
                      child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.black
                        ),),
                    ),
                  ],
                ),
              ),


            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  SignInScreen(),
                  SignUp()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
