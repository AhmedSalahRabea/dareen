// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';

class ProductOrFavouriteItem extends StatelessWidget {
  final ProductModel model;

  ProductOrFavouriteItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: InkWell(
        onTap: () {
          // navigateTo(
          //     context: context, screen: ProductScreenDetails(model: model));
          navigateTo(
              context: context, screen: ProductDetailsScreen(model: model));
        },
        child: SizedBox(
          height: 130,
          //color: Colors.grey,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  FadeInImage(
                    height: 150,
                    width: 120,
                    placeholder:
                        const AssetImage('assets/images/imageloading.gif'),
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
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    //   const Spacer(),
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
                                    color: Colors.deepOrange, fontSize: 15),
                          ),
                        if (model.newPrice == null || model.newPrice == 0)
                          Text(
                            '${model.price.toString()} جـــ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.deepOrange, fontSize: 15),
                          ),
                        if (model.newPrice != 0 && model.newPrice != null)
                          Text(
                            '${model.price.toString()} جــ',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        IconButton(
                            onPressed: () {
                              buildToast(
                                  message: 'تم إضافة هذا المنتج الي المفضلة',
                                  context: context);
                              // ShopCubit.get(context)
                              //     .changeFavourite(model.id, context);
                            },
                            icon: const Icon(
                              Icons.favorite_sharp,
                              size: 18,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showMyAlertDialog(
                              context: context,
                              title: 'السلة',
                              content:
                                  'تم إضافة هذا المنتج إلي عربة التسوق الخاصة بكم');
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text('أضف إلي عربة التسوق'),
                        style: OutlinedButton.styleFrom(
                          //padding: EdgeInsets.zero,
                          side: const BorderSide(color: Colors.deepOrange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
