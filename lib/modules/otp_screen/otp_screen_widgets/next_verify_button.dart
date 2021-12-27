// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NextOrVerifyButton extends StatelessWidget {
  final VoidCallback? function;
  final String buttonName;
  NextOrVerifyButton({required this.function, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepOrange,
          minimumSize: const Size(80, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 10,
        ),
      ),
    );
  }
}
