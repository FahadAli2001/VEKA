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

  var isSignIn = false.obs;

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var loginButton = Get.width * 0.05;
    return Scaffold(

        body: Column(
          children: <Widget>[

            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage("assets/car.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover
                      )
                  ),
                  width: Get.width ,
                  height: Get.height * 0.45,
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.08
                      ),),
                  ),
                ),

                Positioned(
                  top: 320,
                  right: 90,
                  left: 90,
                  child: Center(
                    child: Obx(()=>
                       Row(
                        children: [
                            GestureDetector(
                              onTap: (){
                                isSignIn.value = false;
                                print(isSignIn.value);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                  Text("SignIn",
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         color: Colors.white,
                                         fontSize: loginButton
                                     ),),


                                    (isSignIn.value == false)? SizedBox(
                                      width: 60,
                                      child: Divider(color: Colors.white,thickness: 2,
                                      ),
                                    ):Container()
                                  ],
                                ),
                              ),
                            ),

                          //
                          SizedBox(
                            width: 80,
                          ),
                          //
                          GestureDetector(
                            onTap: (){
                              isSignIn.value = true;
                              print(isSignIn.value);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Text("SignUp",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: loginButton
                                      ),),

                                  (isSignIn.value == true)? SizedBox(
                                    width: 60,
                                    child: Divider(color: Colors.white,thickness: 2,
                                    ),
                                  ):Container()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            Obx(
    ()=> Expanded(child: (isSignIn.value == false)?SignInScreen():SignUp()
              ),
            )
          ],
        ),

    );
  }
}
