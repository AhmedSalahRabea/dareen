// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/search/search_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';

import 'package:dareen_app/shared/widgets/contacts.dart';
import 'package:dareen_app/shared/widgets/empty_list.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:dareen_app/shared/widgets/product_item_for_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
                title: Text(
                  categoryName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14.sp),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      cubit.toggleBetweenListAndGridView();
                    },
                    icon: cubit.isListView
                        ? const Icon(Icons.apps)
                        : const Icon(Icons.view_list),
                    color: const Color(0xff0097A7),
                    iconSize: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context: context, screen: SearchScreen());
                      },
                      icon: const Icon(Icons.search),
                      color: const Color(0xff0097A7),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  BuildCondition(
                    condition: cubit.products.isNotEmpty,
                    builder: (context) {
                      return cubit.isListView
                          ? ListView.separated(
                              itemBuilder: (_, index) {
                                return ProductOrFavouriteItem(
                                  model: cubit.products[index],
                                );
                              },
                              separatorBuilder: (contextm, index) =>
                                  const MyDivider(),
                              itemCount: cubit.products.length,
                              physics: const BouncingScrollPhysics(),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.w,
                                mainAxisExtent: 23.h,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0.h,
                                childAspectRatio: 3 / 2,
                              ),
                              itemCount: cubit.products.length,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return ProductOrFavouriteItemForGridView(
                                  model: cubit.products[index],
                                );
                              },
                            );
                    },
                    fallback: (context) => EmptyList(
                        image: 'assets/images/emptyCart2.png',
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
