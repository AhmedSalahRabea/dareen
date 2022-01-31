// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class MyDefaultButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final String text;
  final VoidCallback function;
  final double fontSize;
  final double height;
  MyDefaultButton({
    this.width = double.infinity,
    this.backgroundColor = const Color(0xff0097A7),
    this.fontSize = 15,
    this.height = 45,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      //padding: EdgeInsets.symmetric(vertical: 40),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize.sp,
          ),
        ),
        onPressed: function,
        color: backgroundColor,
        elevation: 10,
        // color: Colors.blue,
      ),
    );
  }
}
