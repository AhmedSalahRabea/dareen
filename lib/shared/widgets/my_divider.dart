
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Divider(
    color: Color(0xff0097A7),
    endIndent: 20,
    indent: 20,
    thickness: 1.5,
    // height: 200,
  );
  }
}