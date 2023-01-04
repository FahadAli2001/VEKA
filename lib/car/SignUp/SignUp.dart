import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var SocialAppIconSize = Get.height * 0.03;
    return Container(
      child : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column
            (
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                        suffixIcon: Icon(CupertinoIcons.person),
                        border: OutlineInputBorder()
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "User Id",
                        labelText: "User Id",
                        suffixIcon: Icon(CupertinoIcons.mail),
                        border: OutlineInputBorder()
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
                        border: OutlineInputBorder()
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: Get.height * 0.06,
                  width: Get.width,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Radio(value: 0,
                          groupValue: null, onChanged: null),
                      Text("I agree with Terms & Conditions",
                        style: TextStyle(
                            fontSize: width * 0.04
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: SizedBox(
                  width: Get.width,
                  child: CupertinoButton(
                      color: Colors.black,
                      child: Text("Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.05
                        ),),
                      onPressed: (){}),
                ),
              ),
              //
              Align(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RichText(
                  text: TextSpan(
                    text: "Don't Have An Account? ",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
