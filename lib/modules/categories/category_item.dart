// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/products/products_screen.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';

import 'package:dareen_app/data/models/category_model.dart';
import 'package:dareen_app/shared/components/functions.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel model;

  CategoryItem({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
   // var mediaQueryHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () async {
          ShopCubit.get(context).getFavourites(userId);

          ShopCubit.get(context).getCategoryProducts(model.id);

          navigateTo(
              context: context,
              screen: ProductsScreen(
                categoryName: model.name,
              ));
        },
        child: GridTile(
          child: FadeInImage(
            image: CachedNetworkImageProvider(model.image),
            placeholder: const AssetImage('assets/images/imageloading.gif'),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            alignment: Alignment.bottomCenter,
            child: Text(
              model.name,
              style: const TextStyle(
                height: 1.3,
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
