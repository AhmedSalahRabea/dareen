// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrange,
        //valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }
}
