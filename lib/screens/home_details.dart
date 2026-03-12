import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class HomeDetails extends StatelessWidget {
   HomeDetails({super.key});
   final blog=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //back icon
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: ()=>Get.back(),
                      icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:17,left: 20,right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.coverImage??'No image',height: 300,
                      width: double.infinity,fit: BoxFit.cover),
                  ),
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
                  ),
                  const SizedBox(height: 5,),
                    Text(blog.title??'No title',style: GoogleFonts.abel(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  const SizedBox(height: 5,),
                  Text(blog.description??'No description',style: GoogleFonts.abel(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
