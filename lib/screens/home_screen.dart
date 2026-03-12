import 'package:blog_app/configs/app_config.dart';
import 'package:blog_app/screens/home_details.dart';
import 'package:blog_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/api_controllers/auth_controller.dart';
import '../controllers/api_controllers/blog_controller.dart';
import 'package:intl/intl.dart';



class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final blogController=Get.put(BlogController());
   final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
     body: Obx((){
       return CustomScrollView(
         slivers: [
           SliverAppBar(
             scrolledUnderElevation: 0,
             backgroundColor:AppConfig.primaryColor,
             expandedHeight:120,
             title: Text(AppConfig.AppName,style: GoogleFonts.abel(
               fontWeight: FontWeight.bold,color: Colors.white,
             ),
             ),
             actions: [
               GestureDetector(
                   onTap: (){
                    authController.logout();
                    Get.snackbar('Success', 'Logout successfully');
                   },
                   child: Container(
                       height: 30,
                       width: 30,
                       decoration: BoxDecoration(
                           color: AppConfig.primaryColor,
                           shape: BoxShape.circle,
                           border: Border.all(
                             color: Colors.white,
                             width: 1,
                           )
                       ),
                       child: Icon (Icons.logout,color:Colors.red,))),
               const SizedBox(width: 10,),
               GestureDetector(
                   onTap: (){
                     Get.to(()=>ProfileScreen());
                   },
                   child: Container(
                       height: 30,
                       width: 30,
                   decoration: BoxDecoration(
                     color: AppConfig.primaryColor,
                     shape: BoxShape.circle,
                     border: Border.all(
                       color: Colors.white,
                       width: 1,
                     )
                   ),
                   child: Icon (Icons.perm_identity,color:Colors.white,))),
                 const SizedBox(width: 19,),

             ],
             flexibleSpace:FlexibleSpaceBar(
               background: Padding(
                 padding: const EdgeInsets.only(top: 80,left: 14,right: 15),
                 child: Column(
                   children: [
                     Card(
                       elevation: 5,
                       color: Colors.grey.withOpacity(0.2),
                       child: Container(
                         height: 42,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: TextField(
                           onChanged: (value){
                             blogController.searchByTitle(value);
                           },
                           decoration: InputDecoration(
                             hintText: 'Search a blog...',
                             hintStyle: GoogleFonts.abel(
                               color: Colors.grey,
                               fontSize: 15,
                               fontWeight: FontWeight.w500,
                               letterSpacing: 1.2,
                             ),
                             prefixIcon: Icon(Icons.search_off_rounded,color:AppConfig.primaryColor,),
                             border: InputBorder.none,
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             ),
             automaticallyImplyLeading: false,
             floating: true,
           ),
           if (blogController.isLoading.value)
             SliverFillRemaining(
               child: Center(
                 child: CircularProgressIndicator(
                   color: AppConfig.primaryColor,
                 ),
               ),
             ),
            if (blogController.searchBlog.isEmpty)
             SliverFillRemaining(
               hasScrollBody: false,
               child: Center(
                 child: Text(
                   'No result found!',
                   style: GoogleFonts.abel(
                     color: Colors.black,
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     letterSpacing: 1.2,
                   ),
                 ),
               ),
             )
           else
           SliverList.separated(
               itemCount: blogController.searchBlog.length,
               separatorBuilder: (context,index){
                 return const SizedBox(height: 10,);
               },
               itemBuilder: (context,index){
                 var blog=blogController.searchBlog[index];
                   return Padding(
                   padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                   child: Card(
                     child: Container(
                       height: 270,
                       width: double.infinity,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.2),
                               spreadRadius: 5,
                               blurRadius: 7,
                               offset: Offset(0,3),
                             )
                           ]
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           InkWell(
                             onTap: (){
                               Get.to(()=>HomeDetails(),arguments: blog);
                             },
                             child: ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image.network(blog.coverImage??'No image',height: 180,
                                   width: double.infinity,fit: BoxFit.cover,
                                   errorBuilder: (context,error,stackTrace){
                                     return Container(
                                       height: 180,
                                       width: double.infinity,
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Icon(Icons.broken_image_rounded,color: AppConfig.primaryColor,size: 180,)
                                         ],
                                       ),
                                     );
                                   },
                                 )),
                           ),
                           const SizedBox(height: 10,),
                           Padding(
                             padding: const EdgeInsets.only(left: 10,right: 10),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(blog.title??'No title',overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                   style: GoogleFonts.abel(
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontWeight: FontWeight.bold,
                                 ),),
                                 const SizedBox(height: 10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Published by :',overflow: TextOverflow.ellipsis, style: GoogleFonts.abel(
                                       color: Colors.black,
                                       fontSize: 17,
                                       fontWeight: FontWeight.bold,
                                     ),),
                                     const SizedBox(width: 8,),
                                     Text(blog.user?.name??'Anonymous post',overflow: TextOverflow.ellipsis, style: GoogleFonts.abel(
                                       color: Colors.black,
                                       fontSize: 18,
                                       fontWeight: FontWeight.bold,
                                     ),),
                                     const Spacer(),
                                     Text(blog.createdAt !=null?
                                     DateFormat('MMM dd, yyyy').format(DateTime.parse(blog.createdAt!))
                                         :'Not available',overflow: TextOverflow.ellipsis,style: GoogleFonts.abel(
                                       color: Colors.grey,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w500,
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
                 );
               }),

             //end section
           if(blogController.searchBlog.isNotEmpty)
             SliverToBoxAdapter(
               child: Column(
                 children: [
                   const SizedBox(height: 5,),
                   const Divider(color: Colors.blueGrey,
                     indent: 25,
                     endIndent: 25,
                     thickness: 2,),
                   const SizedBox(height: 5,),
                   Text('You are all caught up!',style:GoogleFonts.abel(
                     color:Colors.black,
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                     letterSpacing: 1.2,
                   ),),
                   const SizedBox(height: 20,),
                 ],
               ),
             ),
         ],
       );
     })
    );
  }
}
