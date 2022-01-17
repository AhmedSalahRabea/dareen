// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class MyLikeButton extends StatelessWidget {
  final ProductModel model;

  MyLikeButton({required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return LikeButton(
          isLiked: cubit.productsInFavourites.containsKey(model.id),
          circleColor: CircleColor(
            start: Theme.of(context).primaryColor,
            end: const Color(0xff0099cc),
          ),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Theme.of(context).primaryColor,
            dotSecondaryColor: const Color.fromRGBO(255, 0, 0, 1),
          ),
          bubblesSize: 80,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Theme.of(context).primaryColor : Colors.grey,
              size: 30,
            );
          },

          animationDuration: const Duration(milliseconds: 1000),
          circleSize: 25,

          onTap: (bool isLiked) async {
            await ShopCubit.get(context).addOrDeleteProductToFavourite(
              productId: model.id,
              productModel: model,
              context: context,
            );
            return true;
          },

          // likeCount: 665,
          // countBuilder: (int? count, bool isLiked, String text) {
          //   var color = isLiked ? Colors.yellow : Colors.grey;
          //   Widget result;
          //   if (count == 0) {
          //     result = Text(
          //       "love",
          //       style: TextStyle(color: color),
          //     );
          //   } else {
          //     result = Text(
          //       text,
          //       style: const TextStyle(color: Theme.of(context).primaryColor),
          //     );
          //   }
          //   return result;
          // },
        );
      },
    );
  }
}
