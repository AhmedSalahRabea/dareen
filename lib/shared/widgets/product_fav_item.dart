// ignore_for_file: override_on_non_overriding_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dareen_app/modules/product_details/product_details_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_outlined_button.dart';
import 'package:flutter/material.dart';

class ProductOrFavouriteItem extends StatelessWidget {
  const ProductOrFavouriteItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: InkWell(
        onTap: () {
          // navigateTo(
          //     context: context, screen: ProductScreenDetails(model: model));
          navigateTo(context: context, screen: ProductDetailsScreen());
        },
        child: Container(
          height: 130,
          //color: Colors.grey,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  const FadeInImage(
                    height: 150,
                    width: 120,
                    placeholder:
                        const AssetImage('assets/images/imageloading.gif'),
                    image: CachedNetworkImageProvider(
                        'https://janatonline.com/Content/Images/Products/al-osra-white-sugar-1-kg-68614-600.jpg'),
                    fit: BoxFit.contain,
                  ),

                  //   if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سكر أبيض 1 كجم',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    //   const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '15 جــ',
                          //  '${model.price.toString()} EGP',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.deepOrange, fontSize: 15),
                        ),
                        // if (model.discount != 0)
                        Text(
                          '20 جـ',
                          //     '${model.oldPrice.toString()} EGP',
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
                            icon: Icon(
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
                                  'تم إضافة هذا المنتج إلي سلة التسوق الخاصة بكم');
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text('أضف إلي السلة'),
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
