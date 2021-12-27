
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class PhoneIntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your phone number ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin:const EdgeInsets.symmetric(horizontal: 2),
          child:const Text(
            'Please Enter your phone number for verify your account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
