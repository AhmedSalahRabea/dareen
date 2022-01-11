// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';

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
                  FadeInImage(
                    height: mediaQueryHeight / 5,
                    placeholder:
                        const AssetImage('assets/images/imageloading.gif'),
                    image: CachedNetworkImageProvider(model.image),
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),

                  // Stack(alignment: AlignmentDirectional.bottomStart, children: [
                  //   SizedBox(
                  //     height: mediaQueryHeight / 5,
                  //     child: PageView.builder(
                  //       itemBuilder: (context, index) => ClipRRect(
                  //         borderRadius: BorderRadius.circular(50),
                  //         child: FadeInImage(
                  //           height: double.infinity,
                  //           placeholder: const AssetImage(
                  //               'assets/images/imageloading.gif'),
                  //           image: CachedNetworkImageProvider(images[index]),
                  //           width: double.infinity,
                  //           fit: BoxFit.contain,
                  //         ),
                  //       ),
                  //       itemCount: images.length,
                  //       physics: const BouncingScrollPhysics(),
                  //       controller: boardController,
                  //     ),
                  //   ),
                  //   SmoothPageIndicator(
                  //     controller: boardController,
                  //     count: images.length,
                  //     effect: const ExpandingDotsEffect(
                  //       dotColor: Colors.grey,
                  //       dotHeight: 10,
                  //       activeDotColor: Colors.deepOrange,
                  //       radius: 10,
                  //       dotWidth: 15,
                  //     ),
                  //   ),
                  // ]),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      model.name,
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
                    MyDivider(),
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
                  MyDivider(),
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
                    'أضف إلي عربة التسوق',
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
