// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/search/search_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
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
                'Dareen',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 27),
              ),
              centerTitle: true,
              leadingWidth: 100,
              leading: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return TextButton.icon(
                      onPressed: () {
                        cubit.changeIndexToMaychCartScreen(context);
                        CartCubit.get(context).getCartProducts();
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label:
                          Text('${CartCubit.get(context).cartProducts.length}'),
                    );
                  }),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                    onPressed: () {
                      navigateTo(context: context, screen: SearchScreen());
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.deepOrange,
                    iconSize: 30,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.curretIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.curretIndex,
              onTap: (index) {
                cubit.changeBottomNavIndex(index);
                if (index == 2) {
                  CartCubit.get(context).getCartProducts();
                  ShopCubit.get(context).isFloatingActionButtonShown = false;
                }
              },
              iconSize: 27,
              type: BottomNavigationBarType.fixed,
            ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton:   Directionality(
                textDirection: TextDirection.ltr,
                child: Visibility(
                  visible: ShopCubit.get(context).isFloatingActionButtonShown,
                  child: FloatingActionButton(
                    onPressed: () {
                      myModalBottomSheet(context: context);
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    splashColor: Colors.deepOrange,
                    // extendedTextStyle: Theme.of(context).textTheme.bodyText1,
                    // extendedIconLabelSpacing: 5,
                    // extendedPadding: const EdgeInsets.only(right: 5, left: 10),
                    tooltip: 'اضغط هنا لطلب توكتوك',
                    foregroundColor: Colors.deepOrange,
                    // label: const Text('لطلب توكتوك'),
                    //icon: Icon(Icons.cake_rounded),
                    child: Image.asset(
                      'assets/images/toktok.png',
                      width: 60,
                      height: 50,
                    ),
                  ),
                ),
              ),
              
            
          ),
        );
      },
    );
  }
}
