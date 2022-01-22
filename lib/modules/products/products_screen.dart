// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';

import 'package:dareen_app/shared/widgets/contacts.dart';
import 'package:dareen_app/shared/widgets/empty_list.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;
  ProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(categoryName),
              ),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  BuildCondition(
                    condition: cubit.products.isNotEmpty,
                    builder: (context) {
                      return ListView.separated(
                        itemBuilder: (_, index) {
                          return ProductOrFavouriteItem(
                            model: cubit.products[index],
                          );
                        },
                        separatorBuilder: (contextm, index) =>
                            const MyDivider(),
                        itemCount: cubit.products.length,
                        physics: const BouncingScrollPhysics(),
                      );
                    },
                    fallback: (context) => EmptyList(
                        image: 'assets/images/emptyCart.png',
                        text: 'لا يوجد منتجات في هذا القسم'),
                  ),
                  if (categoryName == 'صيدلية' || categoryName == 'pharmacy')
                    const Padding(
                      padding: EdgeInsets.only(
                          bottom: 20, top: 0, right: 20, left: 20),
                      child: ContactsWidget(
                        whatsappString: 'لإرسال الروشتة عبر الواتساب',
                        callString: 'للإتصال بنا مباشرةً',
                        screenHeightDivideNumber: 20,
                      ),
                    ),
                ],
              ),
            ),
          );

          //    fallback: (context) => const Center(child: CircularProgressIndicator()),
        });
  }
}
