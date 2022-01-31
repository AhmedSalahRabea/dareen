// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final double fontSize;
  MyOutlinedButton({
    required this.text,
    required this.onpressed,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onpressed,
      style: OutlinedButton.styleFrom(
        elevation: 5,
        backgroundColor: Colors.white,
        //  padding: const EdgeInsets.all(20),
        //  fixedSize: Size(100, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        minimumSize: const Size(50, 30),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      ),
      child: Text(
        text,
        style: GoogleFonts.tajawal(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
