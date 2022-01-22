// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String image;
  final String text;
  EmptyList({
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height / 2,
          ),
          Text(text),
        ],
      ),
    );
  }
}
