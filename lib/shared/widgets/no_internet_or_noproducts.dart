// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class NoInterNetOrNoProducts extends StatelessWidget {
  final String text;
  final IconData icon;
  NoInterNetOrNoProducts({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 150,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 20),
           Text(text),
        ],
      ),
    );
  }
}
