// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:dareen_app/data/models/category_model.dart';
import 'package:dareen_app/data/models/favourite_model.dart';
import 'package:dareen_app/data/models/product_model.dart';
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
  //========= method to get Catageories from api=====
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

//========== method to get the products into a particular category =======
  ProductsModel? productsModel;
  List<ProductModel> products = [];
  void getCategoryProducts(String categoryId) {
    emit(ProductsLoading());
    DioHelper.getData(
      url: CATEGORYPRODUCTS,
      query: {
        'category_id': categoryId,
      },
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      //  print(productsModel!.data![0].name);
      productsModel!.data!.forEach((element) {
        products.add(element);
      });

      emit(ProductsGetSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ProductsGetError());
    });
  }

//========== method to get favourites =======
  late FavouritesModel? favouritesModel;
  List<ProductModel> favourites = [];
  void getFavourites(int? userId) {
    emit(FavouritesLoading());
    DioHelper.getData(
      url: FAVOURITES,
      query: {
        'user_id': userId,
      },
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      if (favouritesModel != null) {
        if (favouritesModel!.data != null) {
          favouritesModel!.data!.forEach((element) {
            favourites.add(element.product);
          });
        }
      }
      emit(FavouritesGetSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FavouritesGetError());
    });
  }

  //========Bottom navigation bar logic==========
  int currebIndex = 0;
  void changeBottomNavIndex(int index) {
    currebIndex = index;
    if (currebIndex == 1) {
      getFavourites(userId!);
    }else{
      favourites = [];
    }
    
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
