import 'dart:convert';
import 'package:blog_app/configs/app_config.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/services/blog_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BlogController extends GetxController{

  var isLoading=false.obs;
  var allBlog=<BlogModel>[].obs;
  var searchBlog=<BlogModel>[].obs;


  @override
  void onInit() {
    getBlog();
    super.onInit();
  }


  getBlog()async{
    try{
      isLoading.value=true;
      final response=await BlogService().getBlog();
      if(response.statusCode==200){
        List<dynamic>data=jsonDecode(response.body);
        allBlog.value=data.map((e) => BlogModel.fromJson(e)).toList();
        searchBlog.value=allBlog;
      }
    }catch(e){
      print(e.toString());
    }finally{
      isLoading.value=false;
    }
  }


  //search
 searchByTitle(String query){
    if(query.isEmpty){
      searchBlog.value=allBlog;
    }else{
     searchBlog.value=allBlog.where((blog){
       final blogTitle = blog.title?.toLowerCase() ?? '';
       return blogTitle.contains(query.toLowerCase());
     }).toList();
    }
 }




}