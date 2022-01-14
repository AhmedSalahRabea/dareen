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
    return Column(
      children: [
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height / 2,
        ),
        Text(text),
      ],
    );
  }
}
