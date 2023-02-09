import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:veka/house/Signup/signUpScreen.dart';


import '../BUYING/dashboard/houseDashboard.dart';
import '../BUYING/home/homeScreen.dart';
import 'LoginController.dart';

class loginSxreen extends StatelessWidget {
  const loginSxreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var SocialAppIconSize = Get.height * 0.03;
    loginController lc = Get.put(loginController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                 Padding(padding: EdgeInsets.only(top: 40),
                 child:  Align(
                   alignment: Alignment.topLeft,
                   child: Text("Welcome Back",
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                         fontSize: Get.width * 0.07
                     ),),
                 ),),
                  //---
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Login with your email and password",
                  style: TextStyle(

                      color: Colors.grey,
                      fontSize: Get.width * 0.04
                  ),),

              ),
          ),
                  //----
                  SizedBox(height: 100,),
                  //---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: TextFormField(
                      controller: lc.username,
                      style: TextStyle(
                          height: 0.5
                      ),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          hintText: "User Name",
                          labelText: "User Name",
                          suffixIcon: Icon(CupertinoIcons.person),
                          border: OutlineInputBorder()
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return "Please enter User-name";
                        }
                      },
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Obx(()=>
                       TextFormField(
                          obscureText: lc.isHidepass.value,
                          validator: (String? val){
                            if(val!.isEmpty){
                              return "Enter password";
                            }
                          },
                          style: TextStyle(
                              height: 0.5
                          ),
                          controller: lc.password,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red
                            ),
                              hintText: "Password",
                              labelText: "Password",
                              suffixIcon: InkWell(
                                onTap: (){
                                  if(lc.isHidepass.value == true){
                                    lc.isHidepass.value = false;
                                  }else{
                                    lc.isHidepass.value = true;
                                  }
                                },
                                  child: (lc.isHidepass.value == true)?Icon(CupertinoIcons.eye_slash_fill):
                                      Icon(CupertinoIcons.eye)
                              ),
                              border: OutlineInputBorder()
                          )
                      ),
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width,
                      //color: Colors.red,
                      child: Obx(
                            ()=> Row(
                          children: [
                            Checkbox(
                                value: lc.Value.value,
                                onChanged: lc.handleRadioValueChanged
                            ), //Ch
                            Text("Remember me",
                              style: TextStyle(
                                  fontSize: Get.width * 0.04
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: SizedBox(
                      width: Get.width,
                      child: CupertinoButton(
                          color: Colors.black,
                          child: Text("Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.05
                            ),),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              lc.SignIn();
                            }
                          }),
                    ),
                  ),
                  //-----------
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(

                      children: [
                        Expanded(child: Divider(color: Colors.grey,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Or"),
                        ),
                        Expanded(child: Divider(color: Colors.grey,)),
                      ],
                    ),
                  ),
                  //--------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 118,vertical: 20),
                    child: Container(
                      width: Get.width,
                      //height: 100,
                      //color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(homeScreen());
                            },
                            child: FaIcon(FontAwesomeIcons.facebook,
                              color: Colors.grey,
                              size: SocialAppIconSize,),
                          ),
                          FaIcon(FontAwesomeIcons.instagram,
                            color: Colors.grey,
                            size: SocialAppIconSize,),
                          FaIcon(FontAwesomeIcons.twitter,
                            color: Colors.grey,
                            size: SocialAppIconSize,),
                        ],
                      ),
                    ),
                  ),
                  //--------------
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: (){
                        Get.to(signUpscreen());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have An Account? ",
                          style: TextStyle(
                              fontSize: Get.width * 0.04,
                              color: Colors.grey
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: 'Sign Up', style:
                            TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
