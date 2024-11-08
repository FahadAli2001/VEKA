import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/car/SignUp/SignupController.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var groupvalue = true.obs;
  bool isSignUp = false;
  var width = Get.width;
  var SocialAppIconSize = Get.height * 0.03;
  SignUpController suc = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: suc.username,
                    style: const TextStyle(height: 0.5),
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      hintText: "User Name",
                      labelText: "User Name",
                      suffixIcon: Icon(
                        CupertinoIcons.person_alt,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter User-name";
                      }
                    },
                  ),
                ),
                //

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    validator: (val) {
                      /* if(val!= EmailValidator.validate(val.toString())){
                        return "Enter valid email";
                      }*/
                      if (val == "") {
                        return "Enter email";
                      }
                    },
                    controller: suc.email,
                    style: const TextStyle(height: 0.5),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.red),
                      hintText: "Email",
                      labelText: "Email",
                      suffixIcon: Icon(
                        CupertinoIcons.mail,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                        obscureText: suc.isHidepass.value,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Enter password";
                          } else if (val.length < 8) {
                            return "Enter mini 8 digit password";
                          }
                        },
                        controller: suc.password,
                        style: const TextStyle(height: 0.5),
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: const TextStyle(color: Colors.black),
                          errorStyle: const TextStyle(color: Colors.red),
                          hintText: "Password",
                          labelText: "Password",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                if (suc.isHidepass.value == true) {
                                  suc.isHidepass.value = false;
                                } else {
                                  suc.isHidepass.value = true;
                                }
                              },
                              child: (suc.isHidepass.value == true)
                                  ? const Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye,
                                      color: Colors.black,
                                    )),
                          border: const OutlineInputBorder(),
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
                    child: Row(
                      children: [
                        Obx(
                          () => Radio(
                            value: true,
                            groupValue: suc.Value.value,
                            onChanged: (bool? val) =>
                                suc.handleRadioValueChanged(val),
                            activeColor: Colors.black,
                          ),
                        ),
                        //
                        Text(
                          "I agree with Terms & Conditions",
                          style: TextStyle(fontSize: width * 0.04),
                        ),
                      ],
                    ),
                  ),
                ),

                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: SizedBox(
                    width: Get.width,
                    child: CupertinoButton(
                        color: Colors.black,
                        child: (isSignUp == true)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign - Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05),
                              ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (isSignUp != true) {
                              suc.checkIsAgree();
                            }
                            setState(() {
                              isSignUp = true;
                            });
                            if (mounted) {
                              isSignUp = false;
                            }

                            //suc.UserSignUp();
                          }
                        }),
                  ),
                ),
                //
                /* Align(
                  alignment: Alignment.center,
                  child: Text("or login with ",
                    style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.grey
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 118,vertical: 20),
                  child: Container(
                    width: Get.width,
                    //height: 100,
                    //color: Colors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){

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
                /* Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: RichText(
                    text: TextSpan(
                      text: "Already Have An Account? ",
                      style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.grey
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Sign In', style:
                        TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),

                      ],
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
