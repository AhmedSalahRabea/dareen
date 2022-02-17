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
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProductOrFavouriteItemForGridView extends StatelessWidget {
  final ProductModel model;
  ProductOrFavouriteItemForGridView({required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          //  ShopCubit cubit = ShopCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: InkWell(
              onTap: () {
                navigateTo(
                  context: context,
                  screen: ProductDetailsScreen(model: model),
                );
              },
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      FadeInImage(
                        height: 20.h,
                        width: 15.w,
                        placeholder:
                            const AssetImage('assets/images/imageloading.gif'),
                        image: CachedNetworkImageProvider(model.images![0].image!),
                        fit: BoxFit.contain,
                      ),
                      if (model.newPrice != null && model.newPrice != 0)
                        Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: Text(
                            'عرض خاص',
                            style: GoogleFonts.tajawal(
                              color: Colors.white,
                              fontSize: 7.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 1.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          model.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 9.sp),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (model.newPrice != null && model.newPrice != 0)
                              Text(
                                '${model.newPrice.toString()} جـــ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 9.sp,
                                    ),
                              ),
                            if (model.newPrice == null || model.newPrice == 0)
                              Text(
                                '${model.price.toString()} جـــ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 9.sp,
                                    ),
                              ),
                            if (model.newPrice != 0 && model.newPrice != null)
                              Text(
                                '${model.price.toString()} جــ',
                                style: GoogleFonts.tajawal(
                                  color: Colors.grey,
                                  fontSize: 6.sp,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 0.3.h,
                                ),
                              ),
                            MyLikeButton(
                              model: model,
                              iconSize: 20,
                            ),
                          ],
                        ),
                        //   Spacer(),
                        BlocConsumer<CartCubit, CartState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                height: 4.h,
                                child: OutlinedButton(
                                  onPressed: () {
                                    CartCubit.get(context).addProductToCart(
                                      context: context,
                                      productId: model.id,
                                    );
                                  },
                                  child: Text(
                                    'أضف للعربة',
                                    style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
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
          );
        });
  }
}
