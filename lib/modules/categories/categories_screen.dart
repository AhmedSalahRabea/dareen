// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/categories/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return BuildCondition(
            condition: cubit.categoriesModel != null,
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3.5,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 0.5,
                ),
                itemCount: cubit.categoriesModel!.data!.length,

                //  shrinkWrap: true,
                physics: const BouncingScrollPhysics(),

                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  // ignore: prefer_const_constructors
                  return CategoryItem(
                    model: cubit.categoriesModel!.data![index],
                  );
                },
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
