// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:dareen_app/data/models/category_model.dart';
import 'package:dareen_app/modules/cart/cart_screen.dart';
import 'package:dareen_app/modules/categories/categories_screen.dart';
import 'package:dareen_app/modules/favourite/favourite_screen.dart';
import 'package:dareen_app/modules/settings/setting_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);
  //=========method to get Catageories from api=====
  CategoriesModel? categoriesModel;
  void getCategoryData(BuildContext context) {
    emit(CategoriesGetLoading());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesGetSuccess());
    }).catchError((error) {
      print(error.toString());
      showMyAlertDialog(
          context: context,
          title: 'خطأ اثناء تحميل الاقسام',
          content: error.toString());
      emit(CategoriesGetFailed());
    });
  }

  //========Bottom navigation bar logic==========
  int currebIndex = 0;
  void changeBottomNavIndex(int index) {
    currebIndex = index;
    emit(ShopChangeBottomNavBar());
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'الصفحة الرئيسية',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'المفضلة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'السلة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'الإعدادات',
    ),
  ];

  List<Widget> screens = [
    CategoriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    SettingScreen(),
  ];
}
