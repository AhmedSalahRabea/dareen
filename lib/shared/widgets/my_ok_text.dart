// ignore_for_file: override_on_non_overriding_member, unused_local_variable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOkTextButtonForDailog extends StatelessWidget {
  final String okOrCancel;
  final double fontSize;

  const MyOkTextButtonForDailog({this.okOrCancel = 'حسناً', this.fontSize = 15});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        okOrCancel,
        style: GoogleFonts.tajawal(fontSize: fontSize, fontWeight: FontWeight.bold,),
      ),
    );
  }
}
