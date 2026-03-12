import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../configs/app_config.dart';
import '../controllers/api_controllers/auth_controller.dart';
import '../widgets/blog_widget.dart';
import '../widgets/custom_button.dart';


class UpdateBlog extends StatelessWidget {
   UpdateBlog({super.key});
  final authController=Get.put(AuthController());
   final post = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final id = post.id;
    final oldImageUrl = post.coverImage ?? "";
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
                  child: Form(
                    key: authController.blogUploadKey,
                    child: Column(
                      children: [
                        BlogWidget(
                          controller: authController.blogTitle,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          labelText: 'Title',
                          hintText: 'Enter a title',
                        ),
                        const SizedBox(height: 15),
                        BlogWidget(
                          controller: authController.blogDescription,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                          labelText: 'Description',
                          hintText: 'Enter a description',
                          maxLines: 6,
                        ),

                        // Image selection buttons
                        Padding(
                          padding: const EdgeInsets.only(top: 27, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  authController.pickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.photo_library, color: AppConfig.primaryColor),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  authController.pickImage(ImageSource.camera);
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.camera_alt_outlined, color: AppConfig.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Image preview
                        Obx(() {
                          bool hasNewImage = authController.selectedImagePath.value.isNotEmpty;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Image Preview:", style: GoogleFonts.abel(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white, width: 2),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: hasNewImage
                                      ? Image.file(File(authController.selectedImagePath.value),
                                      fit: BoxFit.cover)
                                      : Image.network(oldImageUrl, fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          );
                        })


                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Upload Button Section
            Obx(() => authController.isLoading.value
                ? Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: CircularProgressIndicator(color: AppConfig.primaryColor),
              ),
            )
                : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
              child: CustomButton(
                onTap: () {
                  if (authController.blogUploadKey.currentState!.validate()) {
                    if (authController.selectedImagePath.value.isEmpty) {
                      Get.snackbar('Error', 'Please select an image');
                    } else {
                     authController.updateBlog(id, oldImageUrl);
                    }
                  }
                },
                height: 47,
                width: double.infinity,
                color: AppConfig.primaryColor,
                labelColor: Colors.white,
                label: 'Upload',
              ),
            )),
          ],
        ),
      ),
    );
  }
}
