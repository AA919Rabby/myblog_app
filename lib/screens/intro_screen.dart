import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/app_config.dart';
import 'package:get/get.dart';
import '../controllers/introscreen_timer controller.dart';



class IntroScreen extends StatelessWidget {
   IntroScreen({super.key});

  //calling the timer from introscreentimercontroller
  final controller=Get.put(IntroscreenTimercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container (
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg.jpg'),fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.blue.withOpacity(0.5),
              BlendMode.darken,
            ),
          )
        ),
        child: BackdropFilter(filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          color: Colors.blue.withOpacity(0.01),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                  Image.asset('assets/images/blogger.jpg',width: 100,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column (
                    children: [
                      SizedBox (
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator (
                          color: Colors.white,
                          strokeWidth: 1.7,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${AppConfig.AppName}',style:
                          GoogleFonts.abel(
                            // color: AppConfig.primaryColor,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(width: 5,),
                          Text('${AppConfig.AppVersion}',style:
                          GoogleFonts.abel(
                            // color: AppConfig.primaryColor,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                          ),),
                        ],
                      )
                    ],
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