// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/cart_model.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  final CartItemData model;
  CartItem({required this.model});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
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
                  screen:
                      ProductDetailsScreen(model: widget.model.productModel),
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
                              widget.model.productModel.image),
                          fit: BoxFit.contain,
                        ),
                        if (widget.model.productModel.newPrice != null &&
                            widget.model.productModel.newPrice != 0)
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
                            widget.model.productModel.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (widget.model.productModel.newPrice != null &&
                                  widget.model.productModel.newPrice != 0)
                                Text(
                                  '${widget.model.productModel.newPrice.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                ),
                              if (widget.model.productModel.newPrice == null ||
                                  widget.model.productModel.newPrice == 0)
                                Text(
                                  '${widget.model.productModel.price.toString()} جـــ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                ),
                              if (widget.model.productModel.newPrice != 0 &&
                                  widget.model.productModel.newPrice != null)
                                Text(
                                  '${widget.model.productModel.price.toString()} جــ',
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
                                  cubit.cartProducts.remove(widget.model);
                                  cubit.deleteProductFromCart(
                                    context: context,
                                    cartId: widget.model.cartId,
                                    productId: widget.model.productModel.id,
                                  );
                                  // if (state is DeleteProductFromCartError)
                                  //   cubit.cartProducts.add(model);
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
                                    //  cubit.increaseQuantity();
                                    setState(() {
                                      quantity += 1;
                                      cubit.cartDetails.addAll({
                                        widget.model.productModel.id: {
                                          'quantity': quantity,
                                          'totalPrice':
                                              '${(widget.model.productModel.newPrice ?? widget.model.productModel.price)! * quantity}',
                                        },
                                      });
                                   ///   cubit.totalPriceFunction();
                                    });
                                    print(cubit.cartDetails);
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Text(
                                '$quantity',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              IconButton(
                                onPressed: () {
                                  // cubit.decreaseQuantity();
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity -= 1;
                                      cubit.cartDetails.addAll({
                                        widget.model.productModel.id: {
                                          'quantity': quantity,
                                          'totalPrice':
                                              '${(widget.model.productModel.newPrice ?? widget.model.productModel.price)! * quantity}',
                                        },
                                      });
                                    });
                                  }
                                  print(cubit.cartDetails);
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Spacer(),
                              Text(
                              //  '${cubit.totalPrice}',
                                 '${(widget.model.productModel.newPrice ?? widget.model.productModel.price)! * quantity}',
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
