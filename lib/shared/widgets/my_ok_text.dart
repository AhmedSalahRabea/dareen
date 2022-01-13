// ignore_for_file: override_on_non_overriding_member, unused_local_variable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyOkTextButtonForDailog extends StatelessWidget {
  final String okOrCancel;
  final double fontSize;

  MyOkTextButtonForDailog({this.okOrCancel = 'حسناً', this.fontSize = 15});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        okOrCancel,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
