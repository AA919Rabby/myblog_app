import 'package:blog_app/screens/add_blog_screen.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      debugShowCheckedModeBanner: false,
       home: IntroScreen(),
    // home: AddBlogScreen(),
    );
  }
}