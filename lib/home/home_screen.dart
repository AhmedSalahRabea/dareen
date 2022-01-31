// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/search/search_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
                style: GoogleFonts.pacifico(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                ),
              ),
              centerTitle: true,
              leadingWidth: 100,
              leading: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                if (state is AddOrDeleteFavouriteSuccess) {
                  CartCubit.get(context).getCartProducts();
                }
              }, builder: (context, state) {
                int cartItemsNumber =
                    CartCubit.get(context).cartProducts.length;
                return TextButton.icon(
                  onPressed: () {
                    cubit.changeIndexToMychCartScreen(context);
                    CartCubit.get(context).getCartProducts();
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: Text('$cartItemsNumber'),
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
                    color: const Color(0xff0097A7),
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
              iconSize: 25,
              selectedFontSize: 10.sp,
              unselectedFontSize: 8.sp,
              type: BottomNavigationBarType.fixed,
            ),
            floatingActionButton: Directionality(
              textDirection: TextDirection.ltr,
              child: Visibility(
                visible: ShopCubit.get(context).isFloatingActionButtonShown,
                child: FloatingActionButton(
                  onPressed: () {
                    myModalBottomSheetForToktok(context: context);
                  },
                  heroTag: 'floatingActionButtonHeroTag',
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  tooltip: 'اضغط هنا لطلب توكتوك',
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
