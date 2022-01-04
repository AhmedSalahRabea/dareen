// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:dareen_app/data/models/add_delete_favourite.dart';
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
    products = [];
    emit(ProductsLoading());
    DioHelper.getData(
      url: CATEGORYPRODUCTS,
      query: {
        'category_id': categoryId,
      },
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
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
    favourites = [];
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

//=====To add or delete product from favourites=====
  // bool isLiked = false;
  AddOrDeleteProductFromFavouritesModel? model;
  void addOrDeleteProductToFavourite({
    required int productId,
    required BuildContext context,
  }) {
    //  this.isLiked = isLiked;
    emit(AddOrDeleteFavouriteLoading());
    DioHelper.postData(
      url: ADDORDELETEFAVOURITE,
      data: {
        'user_id': userId,
        'product_id': productId,
      },
    ).then((value) {
      model = AddOrDeleteProductFromFavouritesModel.fromJson(value.data);
      if (model!.status) {
        mySnackBar(context: context, content: model!.message);
        emit(AddOrDeleteFavouriteSuccess());
        print('now favourite status changed');
      } else {
        // this.isLiked = !isLiked;
        mySnackBar(context: context, content: model!.message);
        emit(AddOrDeleteFavouriteError());
      }
    }).catchError((error) {
      mySnackBar(context: context, content: 'حدث خطأ اثناء إضافة أو حذف منتج من المفضلة يرجي التأكد من الإتصال بالإنترنت وأعد المحاولة ');

      print(error.toString());
      emit(AddOrDeleteFavouriteError());
    });
  }

// ====to determine the like button color===
  late bool isInFavourites;
  bool likeButtonColor(ProductModel model) {
    if (favourites.contains(model)) {
      // isInFavourites = true;
      // emit(ProductAlreadyInFavourites());
      return true;
    } else {
      //isInFavourites = false;
      //  emit(ProductNotInFavourites());
      return false;
    }
  }

  //========Bottom navigation bar logic==========
  int currebIndex = 0;
  void changeBottomNavIndex(int index) {
    currebIndex = index;
    if (currebIndex == 1) {
      getFavourites(userId!);
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
