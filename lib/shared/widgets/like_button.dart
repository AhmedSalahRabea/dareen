// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class MyLikeButton extends StatelessWidget {
  final ProductModel model;

  MyLikeButton({required this.model});
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 25,
      circleColor:
          const CircleColor(start: Colors.deepOrange, end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Color(0xff0099cc),
      ),
      bubblesSize: 60,
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.grey,
          size: 25,
        );
      },
      animationDuration: const Duration(milliseconds: 1500),
      circleSize: 25,
      // likeCountPadding: const EdgeInsets.all(15),
    //  isLiked: ShopCubit.get(context).isLiked,
      onTap: (bool isLiked) async {
        //ShopCubit.get(context).addOrDeleteProductToFavourite(model.id,isLiked);
        //  return true;
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
      //       style: const TextStyle(color: Colors.red),
      //     );
      //   }
      //   return result;
      // },
    );
  }
}
