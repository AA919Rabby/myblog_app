import 'dart:ui';
import 'package:blog_app/auths/register.dart';
import 'package:blog_app/configs/app_config.dart';
import 'package:blog_app/widgets/custom_auth.dart';
import 'package:blog_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/api_controllers/auth_controller.dart';


class Login extends StatelessWidget {
   Login({super.key});
   final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container (
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container (
            color: Colors.blue.withOpacity(0.02),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 33,
                  vertical:80,
                ),
                child: Form(
                  key: authController.loginKey,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text ('Welcome',style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text ('back',style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 30,),
                      Container (
                        // height: 300,
                        // width: MediaQuery.of(context).size.width*99,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding (
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15
                          ),
                          ///TODO Login form
                          child: Column (
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomAuth (
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Email is required';
                                  }if(!GetUtils.isEmail(value)){
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                controller: authController.loginEmail,
                                  labelText: 'Email',
                                  hintText: 'Enter your email'),
                              SizedBox(height: 10,),
                              CustomAuth (
                                controller: authController.loginPassword,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  labelText: 'Password',
                                  hintText: 'Enter your password'),
                              SizedBox(height: 15,),
                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Forget password ?',style: GoogleFonts.abel(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(width: 7,),
                                ],
                              ),
                              SizedBox(height: 15,),
                             Obx(()=> authController.isLoading.value?Center(
                               child: CircularProgressIndicator(
                                 color: AppConfig.primaryColor,
                               ),
                             ):CustomButton(height: 47,
                                 onTap: (){
                                   if(authController.loginKey.currentState!.validate()){
                                     Future.delayed(Duration.zero, () {
                                       authController.login();
                                     });
                                   }
                                 },
                                 width: MediaQuery.of(context).size.width*98,
                                 color:AppConfig.primaryColor,
                                 labelColor: Colors.white,
                                 label: 'Login'),),
                              SizedBox(height: 18,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account ?",
                                    style: GoogleFonts.abel(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(width: 7,),
                                  InkWell(
                                    onTap: (){
                                      Get.to(()=>Register());
                                    },
                                    child: Text (" Register",
                                      style: GoogleFonts.abel(
                                        color: AppConfig.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
