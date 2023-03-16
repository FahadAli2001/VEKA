import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignInController.dart';

class SignInScreen extends StatefulWidget {
  
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var SocialAppIconSize = Get.height * 0.03;

    SignInController sic = Get.put(SignInController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  child: TextFormField(
                      controller: sic.username,
                      style: TextStyle(height: 0.5),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          hintText: "Email",
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Email";
                        } else if (!val.contains("@")) {
                          return "Invalid Email";
                        } else if (val != val.toLowerCase()) {
                          return 'Email cannot contain uppercase letters';
                        }
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                    () => TextFormField(
                        style: TextStyle(height: 0.5),
                        obscureText: sic.isHidepass.value,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Enter password";
                          }
                        },
                        controller: sic.password,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: InkWell(
                                onTap: () {
                                  if (sic.isHidepass.value == true) {
                                    sic.isHidepass.value = false;
                                  } else {
                                    sic.isHidepass.value = true;
                                  }
                                },
                                child: (sic.isHidepass.value == true)
                                    ? Icon(CupertinoIcons.eye_slash_fill)
                                    : Icon(CupertinoIcons.eye)),
                            border: OutlineInputBorder())),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width,
                      //color: Colors.red,
                      child: Row(
                        children: [
                          Radio(
                            groupValue: "SignIn",
                              value: sic.isrem.value,
                              onChanged: sic.handleRadioValueChanged), //Ch
                          Text(
                            "Remember me",
                            style: TextStyle(fontSize: width * 0.04),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: TextButton(
                                onPressed: () {
                                  sic.forgetpassword();
                                },
                                child:  const Text("Forget Password?",style: TextStyle(
                                  color: Colors.black
                                ),)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SizedBox(
                    width: Get.width,
                    child: CupertinoButton(
                        color: Colors.black,
                        child: isSignIn ? const CircularProgressIndicator(
                                  color: Colors.white,
                                ) : Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.05),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if(isSignIn != true){
                            sic.SignIn();
                            }
                            setState(() {
                              isSignIn = true;
                            });
                            if(!mounted){
                              isSignIn = false;
                            }
                          }
                        }),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
