// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel model;
  PageController boardController = PageController();

  // List<String> images = [
  //   'https://janatonline.com/Content/Images/Products/al-osra-white-sugar-1-kg-68614-600.jpg',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwGax5b22_luSu4fweyIoY48wuPiTvFdTvpw&usqp=CAU',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREUI2PCiLkcnUijT5fR4m5FOy5RvL2mXjFcA&usqp=CAU',
  // ];

  ProductDetailsScreen({required this.model});
  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('Dareen')),
        body: Padding(
          padding:
              const EdgeInsets.only(right: 30, top: 5, bottom: 30, left: 30),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero(
                  //   tag: model.id,
                  //   transitionOnUserGestures: false,
                  //   child: FadeInImage(
                  //     height: mediaQueryHeight / 5,
                  //     placeholder:
                  //         const AssetImage('assets/images/imageloading.gif'),
                  //     image: CachedNetworkImageProvider(model.image),
                  //     width: double.infinity,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),

                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                    SizedBox(
                      height: mediaQueryHeight / 5,
                      child: PageView.builder(
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Hero(
                            tag: model.id,
                            child: FadeInImage(
                              height: double.infinity,
                              placeholder: const AssetImage(
                                  'assets/images/imageloading.gif'),
                              image: CachedNetworkImageProvider(
                                  model.images[index]),
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
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
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      model.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                 const MyDivider(),
                  Row(
                    children: [
                      Text(
                        'السعر',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(width: mediaQueryWidth / 2),
                      if (model.newPrice != null && model.newPrice != 0)
                        Text(
                          '${model.newPrice} جــ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      if (model.newPrice == null || model.newPrice == 0)
                        Text(
                          '${model.price} جــ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                    ],
                  ),
                  if (model.newPrice != null && model.newPrice != 0)
                  const  MyDivider(),
                  if (model.newPrice != null && model.newPrice != 0)
                    Row(
                      children: [
                        Text(
                          'السعر قبل الخصم',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(width: mediaQueryWidth / 4),
                        Text(
                          '${model.price} جــ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                      ],
                    ),
                const  MyDivider(),
                  Text(
                    'وصف المنتج',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  if (model.desc != null) const SizedBox(height: 10),
                  if (model.desc != null)
                    Expanded(
                      child: SizedBox(
                        child: ListView(
                          children: [
                            Text(
                              model.desc!,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (model.desc == null)
                    Text(
                      'لا يوجد وصف لهذا المنتج',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                ],
              ),
              BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          CartCubit.get(context).addProductToCart(
                              context: context, productId: model.id);
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'أضف إلي عربة التسوق',
                          style: TextStyle(
                            fontSize: 20,
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
