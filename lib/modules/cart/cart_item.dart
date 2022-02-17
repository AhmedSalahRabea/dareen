// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/cart_model.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
    // var mediaQueryHeight = MediaQuery.of(context).size.height;
    // var mediaQueryWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.w),
            child: InkWell(
              onTap: () {
                navigateTo(
                  context: context,
                  screen:
                      ProductDetailsScreen(model: widget.model.productModel),
                );
              },
              child: SizedBox(
                height: 15.6.h,
                // height: mediaQueryHeight / 6,
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                         
                        FadeInImage(
                          height: 15.h,
                          width: 20.w,
                          placeholder: const AssetImage(
                            'assets/images/imageloading.gif',
                          ),
                          image: CachedNetworkImageProvider(
                            widget.model.productModel.images![0].image!
                          ),
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
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.model.productModel.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontSize: 15.sp,
                                      ),
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
                                        fontSize: 15.sp,
                                      ),
                                ),
                              if (widget.model.productModel.newPrice != 0 &&
                                  widget.model.productModel.newPrice != null)
                                Text(
                                  '${widget.model.productModel.price.toString()} جــ',
                                  style: GoogleFonts.tajawal(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2.sp,
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
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                  // color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity += 1;
                                      //to add the new quantatity to the map which passed to api
                                      cubit.producIdAndQuantityMap.addAll({
                                        widget.model.productModel.id: {
                                          'product_id':
                                              widget.model.productModel.id,
                                          'qty': quantity,
                                        },
                                      });
                                    });
                                    // print(cubit.producIdAndQuantityMap);
                                    //to update the total price value
                                    cubit.totalPriceForAllProducts.addAll({
                                      widget.model.productModel.id:
                                          widget.model.totalPrice * quantity,
                                    });
                                    // print(
                                    //     '========= now ${cubit.totalPriceForAllProducts} ');
                                    cubit.totalPriceFunction();
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Text(
                                '$quantity',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14.sp),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity -= 1;
                                      cubit.producIdAndQuantityMap.addAll({
                                        widget.model.productModel.id: {
                                          'product_id':
                                              widget.model.productModel.id,
                                          'qty': quantity,
                                        },
                                      });
                                    });
                                    //to update the total price value
                                    cubit.totalPriceForAllProducts.addAll({
                                      widget.model.productModel.id:
                                          widget.model.totalPrice * quantity,
                                    });
                                  }
                                  // print(
                                  //     '========= now ${cubit.totalPriceForAllProducts} ');
                                  cubit.totalPriceFunction();

                                  // print(cubit.producIdAndQuantityMap);
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(width: 25.w),
                              Text(
                                //  '${cubit.totalPrice}',
                                '${widget.model.totalPrice * quantity}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14.sp),
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
