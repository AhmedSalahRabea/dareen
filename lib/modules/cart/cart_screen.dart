// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cart Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
