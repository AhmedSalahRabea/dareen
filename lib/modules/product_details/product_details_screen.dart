// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel model;
  PageController boardController = PageController();
  ProductDetailsScreen({required this.model});
  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تفاصيل المنتج',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 15.sp),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.only(right: 5.w, top: 1.h, bottom: 3.h, left: 5.w),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                    SizedBox(
                      height: mediaQueryHeight / 5,
                      child: PageView.builder(
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: FadeInImage(
                            height: double.infinity,
                            placeholder: const AssetImage(
                                'assets/images/imageloading.gif'),
                            image:
                                CachedNetworkImageProvider(model.images[index]),
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        itemCount: model.images.length,
                        physics: const BouncingScrollPhysics(),
                        controller: boardController,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: model.images.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        activeDotColor: Theme.of(context).primaryColor,
                        radius: 10,
                        dotWidth: 15,
                      ),
                    ),
                  ]),
                  SizedBox(height: 3.h),
                  Center(
                    child: Text(
                      model.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // const MyDivider(),
                  Row(
                    children: [
                      Text(
                        'السعر',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16.sp),
                      ),
                      const Spacer(),
                      // SizedBox(width: 50.w),
                      if (model.newPrice != null && model.newPrice != 0)
                        Text(
                          '${model.newPrice} جــ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16.sp),
                        ),
                      if (model.newPrice == null || model.newPrice == 0)
                        Text(
                          '${model.price} جــ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16.sp),
                        ),
                    ],
                  ),
                  if (model.newPrice != null && model.newPrice != 0)
                    const MyDivider(),
                  if (model.newPrice != null && model.newPrice != 0)
                    Row(
                      children: [
                        Text(
                          'السعر قبل الخصم',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 15.sp),
                        ),
                        const Spacer(),
                        //   SizedBox(width: 25.w),
                        Text(
                          '${model.price} جــ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 5.h,
                                  ),
                        ),
                      ],
                    ),
                  const MyDivider(),
                  Text(
                    'وصف المنتج',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16.sp),
                  ),
                  if (model.desc != null) const SizedBox(height: 10),
                  if (model.desc != null)
                    Expanded(
                      child: SizedBox(
                        child: ListView(
                          children: [
                            Text(
                              model.desc!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (model.desc == null)
                    Text(
                      'لا يوجد وصف لهذا المنتج',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16.sp),
                    ),
                ],
              ),
              BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 7.h,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          CartCubit.get(context).addProductToCart(
                              context: context, productId: model.id);
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          'أضف إلي عربة التسوق',
                          style: GoogleFonts.tajawal(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
