import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:veka/car/SignUp/SignupController.dart';
import 'package:veka/house/login/loginScreen.dart';
import 'SignUpController.dart';

class signUpscreen extends StatelessWidget {
  const signUpscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var SocialAppIconSize = Get.height * 0.03;
    final _formKey = GlobalKey<FormState>();
    HouseSignUpController hsp = Get.put(HouseSignUpController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Your Acount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Get.width * 0.07),
                      ),
                    ),
                  ),
                  //---
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Signup with your email and password",
                        style: TextStyle(
                            color: Colors.grey, fontSize: Get.width * 0.04),
                      ),
                    ),
                  ),
                  //----
                  SizedBox(
                    height: 80,
                  ),
                  //--
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      controller: hsp.username,
                      style: TextStyle(height: 0.5),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "User Name",
                          labelText: "User Name",
                          suffixIcon: Icon(CupertinoIcons.person),
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter User-name";
                        }
                      },
                    ),
                  ),
                  //---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        validator: (val) {
                          if (val == "") {
                            return "Enter email";
                          }
                        },
                        controller: hsp.email,
                        style: TextStyle(height: 0.5),
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            hintText: "Email",
                            labelText: "Email",
                            suffixIcon: Icon(CupertinoIcons.mail),
                            border: OutlineInputBorder())),
                  ),
                  //
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: TextFormField(
                          obscureText: hsp.isHidepass.value,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter password";
                            } else if (val.length < 8) {
                              return "Enter mini 8 digit password";
                            }
                            return null;
                          },
                          style: const TextStyle(height: 0.5),
                          controller: hsp.password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    if (hsp.isHidepass.value == true) {
                                      hsp.isHidepass.value = false;
                                    } else {
                                      hsp.isHidepass.value = true;
                                    }
                                  },
                                  child: (hsp.isHidepass.value == true)
                                      ? Icon(CupertinoIcons.eye_slash_fill)
                                      : Icon(CupertinoIcons.eye)),
                              border: OutlineInputBorder())),
                    ),
                  ),
                  //
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter password";
                            } else if (hsp.password.value.text.trim() !=
                                hsp.confirmpassword.value.text.trim()) {
                              return "Password doesn't match";
                            }
                          },
                          obscureText: hsp.isHideconpass.value,
                          controller: hsp.confirmpassword,
                          style: TextStyle(height: 0.5),
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  if (hsp.isHideconpass.value == true) {
                                    hsp.isHideconpass.value = false;
                                  } else {
                                    hsp.isHideconpass.value = true;
                                  }
                                },
                                child: (hsp.isHideconpass.value == true)
                                    ? Icon(CupertinoIcons.eye_slash_fill)
                                    : Icon(CupertinoIcons.eye)),
                            border: OutlineInputBorder(),
                          )),
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
                        () => Row(
                          children: [
                            Checkbox(
                                value: hsp.Value.value,
                                onChanged: hsp.handleRadioValueChanged), //Ch
                            Text(
                              "I agree with Terms & Conditions",
                              style: TextStyle(fontSize: Get.width * 0.04),
                            ),
                          ],
                        ),
                      ),
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
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.05),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("tapppppp");
                              hsp.checkIsAgree();
                              //hsp.SignUp();
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
                          FaIcon(FontAwesomeIcons.facebook,
                            color: Colors.grey,
                            size: SocialAppIconSize,),
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
                        Get.to(loginSxreen());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already Have An Account? ",
                          style: TextStyle(
                              fontSize: Get.width * 0.04, color: Colors.grey),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Sign In',
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
