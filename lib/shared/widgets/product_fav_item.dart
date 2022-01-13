// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOrFavouriteItem extends StatelessWidget {
  final ProductModel model;
  ProductOrFavouriteItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            child: InkWell(
              onTap: () {
                navigateTo(
                  context: context,
                  screen: ProductDetailsScreen(model: model),
                );
              },
              child: SizedBox(
                height: 130,
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        FadeInImage(
                          height: 150,
                          width: 120,
                          placeholder: const AssetImage(
                              'assets/images/imageloading.gif'),
                          image: CachedNetworkImageProvider(model.image),
                          fit: BoxFit.contain,
                        ),
                        if (model.newPrice != null && model.newPrice != 0)
                          Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: const Text(
                              'عرض خاص',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (model.newPrice != null && model.newPrice != 0)
                                Text(
                                  '${model.newPrice.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.deepOrange,
                                          fontSize: 15),
                                ),
                              if (model.newPrice == null || model.newPrice == 0)
                                Text(
                                  '${model.price.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.deepOrange,
                                          fontSize: 15),
                                ),
                              if (model.newPrice != 0 && model.newPrice != null)
                                Text(
                                  '${model.price.toString()} جــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              MyLikeButton(model: model),
                              // IconButton(
                              //   onPressed: () {
                              //     ShopCubit.get(context)
                              //         .addOrDeleteProductToFavourite(
                              //       productId: model.id,
                              //       context: context,
                              //       productModel: model,
                              //     );
                              //   },
                              //   icon: Icon(
                              //     Icons.favorite_sharp,
                              //     size: 25,
                              //     color:
                              //         ShopCubit.get(context).likeButtonColor(model),
                              //   ),
                              // ),
                            ],
                          ),
                          //   Spacer(),
                          BlocConsumer<CartCubit, CartState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      CartCubit.get(context).addProductToCart(context: context,productId: model.id);
                                    },
                                    icon: const Icon(
                                        Icons.shopping_cart_outlined),
                                    label: const Text('أضف إلي عربة التسوق'),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.deepOrange),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
