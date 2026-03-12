import 'package:blog_app/screens/intro_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auths/login.dart';
import '../screens/home_screen.dart';


class IntroscreenTimercontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() async {

    await Future.delayed(const Duration(seconds: 3));

    checkUser();
  }

  checkUser()async{
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token');
    print('$token');
    if(token!=null && token.isNotEmpty){
      Get.offAll(()=>HomeScreen());
    }else{
      Get.offAll(()=>Login());
    }
  }



}