// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyOutLineButton extends StatelessWidget {
  final String text;
  final double screenHeightDivideNumber;
  final VoidCallback function;
  final IconData icon;
  const MyOutLineButton({
    required this.text,
    required this.screenHeightDivideNumber,
    required this.function,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: height / screenHeightDivideNumber,
      child: OutlinedButton.icon(
        onPressed: function,
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        label: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 15,
              ),
          side: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
            style: BorderStyle.none,
          ),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.6),
        ),
      ),
    );
  }
}
