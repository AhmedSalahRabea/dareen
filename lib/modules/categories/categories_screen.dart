// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/categories/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) async {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var mediaQueryHeight = MediaQuery.of(context).size.height;

        return BuildCondition(
          condition:
              cubit.categoriesModel != null && cubit.allProducts.isNotEmpty,
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: LiquidPullToRefresh(
              onRefresh: () async {
                await ShopCubit.get(context).getCategoryData(context);
                await ShopCubit.get(context).getAllProducts();
              },
              borderWidth: 300,
              height: 70,
              showChildOpacityTransition: true,
              springAnimationDurationInMilliseconds: 700,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: mediaQueryHeight / 3.7,

                  //  maxCrossAxisExtent: 200,
                  //   childAspectRatio: 3 / 1,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 0.5,
                ),
                itemCount: cubit.categoriesModel!.data!.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    model: cubit.categoriesModel!.data![index],
                  );
                },
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
