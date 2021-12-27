// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingItem extends StatelessWidget {
  final BoardingModel model;
  OnBoardingItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.body,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            softWrap: true,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
