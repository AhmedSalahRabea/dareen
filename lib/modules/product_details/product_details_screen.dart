// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
  PageController boardController = PageController();

  List<String> images = [
    'https://janatonline.com/Content/Images/Products/al-osra-white-sugar-1-kg-68614-600.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwGax5b22_luSu4fweyIoY48wuPiTvFdTvpw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREUI2PCiLkcnUijT5fR4m5FOy5RvL2mXjFcA&usqp=CAU',
  ];
  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;

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
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                    SizedBox(
                      width: double.infinity,
                      height: mediaQueryHeight / 5.5,
                      child: CarouselSlider(
                        items: images.map((banner) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeInImage(
                              height: double.infinity,
                              placeholder: const AssetImage(
                                  'assets/images/imageloading.gif'),
                              image: CachedNetworkImageProvider(banner),
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          //  height: 200,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          //autoPlayInterval: Duration(seconds: 1),
                          // autoPlayAnimationDuration: Duration(seconds: 3),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                         

                        ),

                      ),
                    ),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: images.length,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        activeDotColor: Colors.deepOrange,
                        radius: 10,
                        dotWidth: 15,
                      ),


                    ),
                  ]),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'سكر أبيض 1 كجم',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  MyDivider(),
                  Row(
                    children: [
                      Text(
                        'السعر',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Spacer(),
                      Text(
                        '25 جنيه ',
                        // '${model!.price} EGY',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  MyDivider(),
                  Row(
                    children: [
                      Text(
                        'السعر قبل الخصم',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Spacer(),
                      Text(
                        '30 جنيه ',

                        //     '${model!.oldPrice} EGY',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ],
                  ),
                  MyDivider(),
                  Text(
                    'وصف المنتج',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      child: ListView(
                        children: [
                          Text(
                            'سكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيض سكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيضسكر أبيض 1 كجم جيد التصنيع ومن أجود أنواع السكر الأبيض',

                            //   model!.description,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showMyAlertDialog(
                        context: context,
                        title: 'السلة',
                        content:
                            'تم إضافة هذا المنتج إلي سلة التسوق الخاصة بكم');
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'أضف إلي السلة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepOrange.withOpacity(.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
