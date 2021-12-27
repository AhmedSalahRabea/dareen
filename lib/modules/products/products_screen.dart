// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;
  ProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: ListView.separated(
          itemBuilder: (contextm, index) => ProductOrFavouriteItem(),
          separatorBuilder: (contextm, index) => MyDivider(),
          itemCount: 10,
        ),
      ),
    );
  }
}
