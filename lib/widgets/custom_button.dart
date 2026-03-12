import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  double height;
  double width;
  String label;
  Color color;
  Color ?labelColor;
  VoidCallback? onTap;
  VoidCallback? onPressed;
  CustomButton({
    required this.height,
    required this.width,
    required this.color,
    required this.label,
    this.onTap,
    this.onPressed,
    this.labelColor,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,style: GoogleFonts.abel(
            color: labelColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
    );
  }
}