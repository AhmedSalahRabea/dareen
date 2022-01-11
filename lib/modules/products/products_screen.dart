// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/contacts.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;
  ProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is ProductsGetSuccess) {
        if (ShopCubit.get(context).products.isEmpty) {
          return showMyAlertDialog(
            context: context,
            title: 'قسم $categoryName',
            // isBarrierDismissible: false,
            content: 'لا يوجد منتجات في هذا القسم يرجي زيارته قريباً ',
            actions: [
              MyDefaultButton(
                  text: 'حسناً',
                  function: () {
                    navigateTo(context: context, screen: HomeScreen());
                  }),
            ],
          );
        }
      }
    }, builder: (context, state) {
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
                    separatorBuilder: (contextm, index) => MyDivider(),
                    itemCount: cubit.products.length,
                  );
                },
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
              if (categoryName == 'صيدلية' || categoryName == 'pharmacy')
                ContactsWidget(),
            ],
          ),
        ),
      );

      //    fallback: (context) => const Center(child: CircularProgressIndicator()),
    });
  }
}
