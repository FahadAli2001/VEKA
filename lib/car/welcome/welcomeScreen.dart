import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../SignIn/SignInScreen.dart';
import '../SignUp/SignUp.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {

  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        body: Column(
          children: <Widget>[

            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/car.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover
                      )
                  ),
                  width: Get.width ,
                  height: Get.height * 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    backgroundImage: AssetImage("assets/Veka-Green.png",
                    ),
                  )),
                ),
                //
                Positioned(
                 top: 120,
                  left: 130,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.08
                      ),),
                  ),
                ),

                Positioned(
                  top: 250,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("SignIn",
                          style: TextStyle(
                            color: Colors.white
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("SignUp",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
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
