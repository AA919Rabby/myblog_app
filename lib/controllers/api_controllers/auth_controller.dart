import 'dart:convert';
import 'package:blog_app/auths/login.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/intro_screen.dart';
import 'package:blog_app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthController extends GetxController{

  //login
  final loginEmail=TextEditingController();
  final loginPassword=TextEditingController();
  final loginKey=GlobalKey<FormState>();

  //register
  final registerKey=GlobalKey<FormState>();
  final registerEmail=TextEditingController();
  final registerName=TextEditingController();
  final registerPassword=TextEditingController();

  //blog upload
  final blogTitle=TextEditingController();
  final blogDescription=TextEditingController();
  final blogUploadKey=GlobalKey<FormState>();



  var token=''.obs;
  var isLoading=false.obs;
  var myPost=<BlogModel>[].obs;
  var selectedImagePath=''.obs;



  @override
  void onInit() {
    fetchPost();
    super.onInit();
  }


  //image selection
  void pickImage(ImageSource source)async{
    final pickedImage=await ImagePicker().pickImage(source: source,imageQuality: 50);
    if(pickedImage!=null){
      selectedImagePath.value=pickedImage.path;
      Get.snackbar('Success', pickedImage.name);
    }else{
      Get.snackbar('Error', 'No image selected');
    }
  }



 //saving the token
  saveToken(String token)async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }



 //login
 login()async{
   try{
     isLoading.value=true;
     final response=await AuthService().login(loginEmail.text.trim(),loginPassword.text.trim());
     if(response.statusCode==200 || response.statusCode==201){
       var data=jsonDecode(response.body);
       token.value=data['access_token']??'';
       await saveToken(token.value);
       print(loginEmail.text);
       print(loginPassword.text);
       Get.snackbar('Success', 'Login as ${loginEmail.text}');
       Get.offAll(() => HomeScreen());
       loginEmail.clear();
       loginPassword.clear();
     }else{
       var e=jsonDecode(response.body);
       Get.snackbar('Error', e['message']);
     }
   }catch(e){
     // print(e.toString());
     Get.snackbar('Error', e.toString());
   }finally{
     isLoading.value=false;
   }
   }


   //register
   register()async{
     String defaultAvatar = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
    try{
      isLoading.value=true;
       final response=await AuthService().register(
           registerEmail.text.trim(),
           registerName.text.trim(), registerPassword.text.trim(),
           defaultAvatar);
       if(response.statusCode==200 || response.statusCode==201){
         var data=jsonDecode(response.body);
         loginEmail.text=registerEmail.text;
         loginPassword.text=registerPassword.text;
         Get.snackbar('Success', 'Register successfully');
         Get.off(Login());
         registerEmail.clear();
         registerName.clear();
         registerPassword.clear();
       }else{
         var e=jsonDecode(response.body);
         Get.snackbar('Error', e['message']);
       }
    }catch(e){
      print(e.toString());
    }finally{
      isLoading.value=false;
    }
  }


   //fetch post
  fetchPost() async {
    try {
      isLoading.value = true;
      final response = await AuthService().fetchPost();
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        myPost.value = data.map((e) => BlogModel.fromJson(e)).toList();

        print("Fetched ${myPost.length} posts");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  //logout method
  logout()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.remove('token');
    token.value='';
    Get.offAll(()=>Login());
  }

  //uploading video in the cloudinary
  uploadImageToCloudinary() async {
    if (selectedImagePath.value.isEmpty) return null;

    try {
      var request = http.MultipartRequest(     //TODO multipart used to send file and data request in one http
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/da9rpdeij/image/upload'),
      );

      request.fields['upload_preset'] = 'blog_app_preset';
      request.files.add(await http.MultipartFile.fromPath('file', selectedImagePath.value));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedData = jsonDecode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedData['secure_url'];
      } else {
        print("Cloudinary Error: $responseData");
        return null;
      }
    } catch (e) {
      print("Cloudinary Catch Error: $e");
      return null;
    }
  }



  //upload blog
  uploadBlog() async {
    try {
      isLoading.value = true;

      String? cloudImageUrl = await uploadImageToCloudinary();

      final response = await AuthService().uploadBlog(
        blogTitle.text.trim(),
        blogDescription.text.trim(),
        cloudImageUrl ?? "https://picsum.photos/800/400",
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Blog uploaded successfully');
        blogTitle.clear();
        blogDescription.clear();
        clearImageData();
        await fetchPost();
        Get.off(() => HomeScreen());
      } else {
        var e = jsonDecode(response.body);
        Get.snackbar('Error', e['message'] ?? 'Upload failed');
      }
    } catch (e) {
      print('Upload error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearImageData() {
    selectedImagePath.value = '';
   }




  //delete blog
deleteBlog(int id)async{
    try{
      final response=await AuthService().deleteBlog(id);
      if(response.statusCode==200 || response.statusCode==204 || response.statusCode==404){
        print(response.statusCode);
        myPost.removeWhere((element) => element.id==id);
        myPost.refresh();
        print(response.statusCode);
        print("Server returned error: ${response.statusCode}");
        Get.snackbar('Success', 'Blog deleted successfully');
        // Get.snackbar(
        //   'Success',
        //   response.statusCode == 404 ? 'Post not found, removing from list' : 'Blog deleted successfully',
        // );
      }else {
        print("Delete failed. Response body: ${response.body}");

        String errorMessage = "Failed to delete post";

        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          var e = jsonDecode(response.body);
          errorMessage = e['message'] ?? errorMessage;
        }
      }
    }catch(e) {
      print('$e');
    }
}


//update blog
updateBlog(int id,String oldImageUrl)async{
 try{
   isLoading.value=true;
   String? finalImageUrl;
   if(selectedImagePath.value.isNotEmpty){
     finalImageUrl=await uploadImageToCloudinary();
   }else{
     finalImageUrl=oldImageUrl;
   }

   final response=await AuthService().updateBlog(
       id,blogTitle.text.trim(),blogDescription.text.trim(),
       finalImageUrl??oldImageUrl);
 if(response.statusCode==200 || response.statusCode==201){
   print(response.statusCode);
   Get.snackbar('Success', 'Blog updated successfully');
   blogTitle.clear();
   blogDescription.clear();
   clearImageData();
   await fetchPost();
   Get.off(()=>HomeScreen());
   }else{
     var e=jsonDecode(response.body);
     Get.snackbar('Error', e['message']);
     print(response.statusCode);
     print('$e');
 }
 }catch(e) {
   print('$e');
 }finally {
   isLoading.value = false;
 }
}



}