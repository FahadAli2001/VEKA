import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/house/Signup/signUpScreen.dart';

import '../../ChooseOption.dart';
import 'LoginController.dart';

class loginSxreen extends StatefulWidget {
  loginSxreen({Key? key}) : super(key: key);

  @override
  State<loginSxreen> createState() => _loginSxreenState();
}

class _loginSxreenState extends State<loginSxreen> {
  var SocialAppIconSize = Get.height * 0.03;
  loginController lc = Get.put(loginController());
  bool isSignIn = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            onPressed: () {
              Get.to(() => const ChooseOption());
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.07),
                      ),
                    ),
                  ),
                  //---
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login with your email and password",
                        style: TextStyle(
                            color: Colors.grey, fontSize: Get.width * 0.04),
                      ),
                    ),
                  ),
                  //----
                  const SizedBox(
                    height: 100,
                  ),
                  //---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      controller: lc.username,
                      style: const TextStyle(height: 0.5),
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(color: Colors.black),
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Email",
                          labelText: "Email",
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Email";
                        } else if (!val.contains("@")) {
                          return "Invalid Email";
                        } else if (val != val.toLowerCase()) {
                          return 'Email cannot contain uppercase letters';
                        }
                      },
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Obx(
                      () => TextFormField(
                          obscureText: lc.isHidepass.value,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter password";
                            }
                          },
                          style: const TextStyle(height: 0.5),
                          controller: lc.password,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelStyle: const TextStyle(color: Colors.black),
                              errorStyle: const TextStyle(color: Colors.red),
                              hintText: "Password",
                              labelText: "Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    if (lc.isHidepass.value == true) {
                                      lc.isHidepass.value = false;
                                    } else {
                                      lc.isHidepass.value = true;
                                    }
                                  },
                                  child: (lc.isHidepass.value == true)
                                      ? const Icon(
                                          CupertinoIcons.eye_slash_fill,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          CupertinoIcons.eye,
                                          color: Colors.black,
                                        )),
                              border: const OutlineInputBorder())),
                    ),
                  ),
                  //
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width,
                    //color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Container(
                            width: 200,
                            child: RadioListTile(
                                activeColor: Colors.black,
                                title: const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      //fontSize: Get.width * 0.04
                                      ),
                                ),
                                groupValue: lc.isremember.value,
                                value: true,
                                onChanged: ((bool? value) =>
                                    lc.handleRadioValueChanged(value))),
                          ),
                        ), //Ch

                        //
                        TextButton(
                            onPressed: () {
                              lc.forgetpassword();
                            },
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(
                                  //fontSize: Get.width * 0.04,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: SizedBox(
                      width: Get.width,
                      child: CupertinoButton(
                          color: Colors.black,
                          child: isSignIn
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width * 0.05),
                                ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (isSignIn != true) {
                                lc.SignIn();
                              }
                              setState(() {
                                isSignIn = true;
                              });
                              if (!mounted) {
                                isSignIn = false;
                              }
                            }
                          }),
                    ),
                  ),
                  //-----------
                  /* Padding(
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
                  ),*/
                  //--------------
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => signUpscreen());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have An Account? ",
                          style: TextStyle(
                              fontSize: Get.width * 0.04, color: Colors.grey),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
