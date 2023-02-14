import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:veka/SplashScreen.dart';
import 'dart:ui';
void main() async{
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  //await FacebookAuth.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: SplashScreen(),
    );
  }
}


