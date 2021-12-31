// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
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
          return BuildCondition(
            condition: cubit.productsModel != null,
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: WillPopScope(
                onWillPop: () async {
                  cubit.productsModel == null;
                  print('====== back is clicked');
                  return true;
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(categoryName),
                  ),
                  body: ListView.separated(
                    itemBuilder: (contextm, index) => ProductOrFavouriteItem(
                      model: cubit.productsModel!.data![index],
                    ),
                    separatorBuilder: (contextm, index) => MyDivider(),
                    itemCount: cubit.productsModel!.data!.length,
                  ),
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
