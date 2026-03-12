import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/app_config.dart';
import '../controllers/api_controllers/auth_controller.dart';
import '../widgets/custom_auth.dart';
import '../widgets/custom_button.dart';
import 'login.dart';


class Register extends StatelessWidget {
   Register({super.key});
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
                  vertical: 80,
                ),
                child: Form(
                  key: authController.registerKey,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Register',style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 39,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 60,),
                      Container (
                        // height: 410,
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
                          ///TODO Register form
                          child: Column (
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomAuth (
                                  controller: authController.registerName,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                  labelText: 'Name',
                                  hintText: 'Enter your name'),
                              SizedBox(height: 10,),
                              CustomAuth (
                                  controller: authController.registerEmail,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Email is required';
                                    }if(!GetUtils.isEmail(value)){
                                      return 'Invalid email';
                                    }
                                    return null;
                                  },
                                  labelText: 'Email',
                                  hintText: 'Enter your email'),
                              SizedBox(height: 10,),
                              CustomAuth (
                                  controller: authController.registerPassword,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  labelText: 'Password',
                                  hintText: 'Enter your password'),
                              SizedBox(height: 25,),
                              Obx(()=> authController.isLoading.value?Center(
                                child: CircularProgressIndicator(
                                  color: AppConfig.primaryColor,
                                ),
                              ):CustomButton(height: 47,
                                  onTap: (){
                                 if(authController.registerKey.currentState!.validate()){
                                   authController.register();
                                 }
                                  },
                                  width: MediaQuery.of(context).size.width*98,
                                  color:AppConfig.primaryColor,
                                  labelColor: Colors.white,
                                  label: 'Register'),),
                              SizedBox(height: 18,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account ?",
                                    style: GoogleFonts.abel(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  SizedBox(width: 7,),
                                  InkWell(
                                    onTap: (){
                                      Get.to(()=>Login());
                                    },
                                    child: Text ("Login",
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
