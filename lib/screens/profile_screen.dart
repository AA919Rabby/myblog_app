import 'dart:io';
import 'package:blog_app/screens/update_blog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../configs/app_config.dart';
import '../controllers/api_controllers/auth_controller.dart';
import 'add_blog_screen.dart';



class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => AddBlogScreen()),
                    child: Text(
                      'Add blog +',
                      style: GoogleFonts.abel(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17),

            // Main Content Section
            Obx(() {
              if (authController.isLoading.value) {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              }

              if (authController.myPost.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No post found !',
                      style: GoogleFonts.abel(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: authController.myPost.length,
                  itemBuilder: (context, index) {
                    final post = authController.myPost[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Popupmenu
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: _buildImage(index, post.coverImage),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: PopupMenuButton<String>(
                                  // Dot
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 12,
                                    child: Icon(Icons.more_vert, size: 20, color: Colors.black),
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      authController.blogTitle.text=post.title??'';
                                      authController.blogDescription.text=post.description??'';
                                      //authController.selectedImagePath.value=post.coverImage??"";
                                      authController.selectedImagePath.value = '';
                                     Get.to(()=>UpdateBlog(),arguments: post);
                                      print("Edit tapped for post: ${post.id}");
                                    } else if (value == 'delete') {
                                      authController.deleteBlog(post.id!);
                                      print("Delete tapped for post: ${post.id}");
                                      Get.snackbar('Success', 'Your blog successfully deleted');
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color:AppConfig.primaryColor, size: 20),
                                          const SizedBox(width: 4),
                                          const Text("Edit"),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: const Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red, size: 20),
                                          SizedBox(width: 4),
                                          Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                            // texyt
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title ?? 'No title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Author: ${post.user?.name ?? 'Me'}",
                                        style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        post.publishedAt ?? 'N/A',
                                        style: GoogleFonts.abel(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    post.description ?? 'No description',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.abel(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Helper widget
 _buildImage(int index, String? networkUrl) {
    if (index == 0 && authController.selectedImagePath.value.isNotEmpty) {
      return Image.file(
        File(authController.selectedImagePath.value),
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // image shows
    if (networkUrl != null && networkUrl.isNotEmpty) {
      return Image.network(
        networkUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _errorPlaceholder(),
      );
    }

    // error
    return _errorPlaceholder();
  }

   _errorPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
    );
  }
}