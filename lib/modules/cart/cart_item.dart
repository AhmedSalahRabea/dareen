// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/cart_model.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final CartItemData model;
  CartItem({required this.model});

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            child: InkWell(
              onTap: () {
                navigateTo(
                  context: context,
                  screen: ProductDetailsScreen(model: model.productModel),
                );
              },
              child: SizedBox(
                height: mediaQueryHeight / 6,
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        FadeInImage(
                          height: mediaQueryHeight / 7,
                          width: mediaQueryWidth / 4,
                          placeholder: const AssetImage(
                              'assets/images/imageloading.gif'),
                          image: CachedNetworkImageProvider(
                              model.productModel.image),
                          fit: BoxFit.contain,
                        ),
                        if (model.productModel.newPrice != null &&
                            model.productModel.newPrice != 0)
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
                            model.productModel.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (model.productModel.newPrice != null &&
                                  model.productModel.newPrice != 0)
                                Text(
                                  '${model.productModel.newPrice.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.deepOrange,
                                          fontSize: 15),
                                ),
                              if (model.productModel.newPrice == null ||
                                  model.productModel.newPrice == 0)
                                Text(
                                  '${model.productModel.price.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.deepOrange,
                                          fontSize: 15),
                                ),
                              if (model.productModel.newPrice != 0 &&
                                  model.productModel.newPrice != null)
                                Text(
                                  '${model.productModel.price.toString()} جــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              IconButton(
                                onPressed: () {
                                  cubit.deleteProductFromCart(
                                      product: model.productModel);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    cubit.increaseQuantity();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Text(
                                model.quantity.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.decreaseQuantity();
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Spacer(),
                              // const SizedBox(
                              //   width: 30,
                              // ),
                              Text(
                                model.totalPrice.toString(),
                              ),
                            ],
                          ),
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
