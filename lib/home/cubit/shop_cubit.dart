// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:dareen_app/data/models/category_model.dart';
import 'package:dareen_app/data/models/favourite_model.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/data/models/search_model.dart';
import 'package:dareen_app/data/models/success_or_delete_model.dart';
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

  static ShopCubit get(BuildContext? context) => BlocProvider.of(context!);

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
        content: const Text(
          'يرجي التأكد من الإتصال بالإنترنت',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
      emit(CategoriesGetFailed());
    });
  }

  //====when get all products=====
  List<ProductModel> allProducts = [];
  SearchModel? searchModel;

  void getAllProducts() {
    allProducts = [];
    emit(GetAllProductsLoading());
    DioHelper.getData(
      url: GETALLPRODUCTS,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      if (searchModel!.status!) {
        searchModel!.data!.forEach((product) {
          allProducts.add(product);
        });
        emit(GetAllProductsSuccess());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetAllProductsError());
    });
  }

//========== method to get the products into a particular category =======
  ProductsModel? productsModel;
  List<ProductModel> products = [];
  void getCategoryProducts(int categoryId) {
    products = [];
    products = allProducts
        .where((product) => product.categoryId == categoryId)
        .toList();
    emit(ProductsGetSuccess());
  }
  // void getCategoryProducts(String categoryId) {
  //   products = [];
  //   emit(ProductsLoading());
  //   DioHelper.getData(
  //     url: CATEGORYPRODUCTS,
  //     query: {
  //       'category_id': categoryId,
  //     },
  //   ).then((value) {
  //     productsModel = ProductsModel.fromJson(value.data);
  //     productsModel!.data!.forEach((element) {
  //       products.add(element);
  //     });
  //     emit(ProductsGetSuccess());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ProductsGetError());
  //   });
  // }

//========== method to get favourites =======
  late FavouritesModel? favouritesModel;
  List<ProductModel> favourites = [];
  Map<int, bool> productsInFavourites = {};
  //List<int> productsInFavourites = [];

  void getFavourites(int? userId) async {
    favourites = [];
    productsInFavourites = {};
    emit(FavouritesLoading());
    await DioHelper.getData(
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
            productsInFavourites.putIfAbsent(element.product.id, () => true);
            // print('=========updated list $productsInFavourites');
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
  SuccessOrFailedModel? model;
  Future<void> addOrDeleteProductToFavourite({
    required int productId,
    required ProductModel productModel,
    required BuildContext context,
  }) async {
    emit(AddOrDeleteFavouriteLoading());
    await DioHelper.postData(
      url: ADDORDELETEFAVOURITE,
      data: {
        'user_id': userId,
        'product_id': productId,
      },
    ).then((value) {
      model = SuccessOrFailedModel.fromJson(value.data);
      if (model!.status!) {
        mySnackBar(context: context, content: model!.message!);
        if (productsInFavourites.containsKey(productId)) {
          productsInFavourites.remove(productId);
          // print('=========updated list $productsInFavourites');
        } else {
          productsInFavourites.putIfAbsent(productId, () => true);
          print(productsInFavourites);
        }
        emit(AddOrDeleteFavouriteSuccess());
        //  print('=========updated list $productsInFavourites');
      } else {
        mySnackBar(context: context, content: model!.message!);
        emit(AddOrDeleteFavouriteError());
      }
    }).catchError((error) {
      mySnackBar(
          context: context,
          content:
              'حدث خطأ اثناء إضافة أو حذف منتج من المفضلة يرجي التأكد من الإتصال بالإنترنت وأعد المحاولة ');
      print(error.toString());
      emit(AddOrDeleteFavouriteError());
    });
  }

// ====to determine the like button color===
  Color loveButtonColor = Colors.grey;
  Color likeButtonColor(ProductModel model) {
    for (var product in favourites) {
      if (product.id == model.id) {
        loveButtonColor = Colors.red;
        return Colors.red;
      }
    }
    loveButtonColor = Colors.grey;
    return Colors.grey;
  }

  bool isLiked = false;
  bool loveButtonColorForPackage(ProductModel model) {
    for (var product in favourites) {
      if (product.id == model.id) {
        isLiked = true;
        return true;
      }
    }
    isLiked = false;

    return false;
  }

  //=======
  void changeIndexToMaychCartScreen(BuildContext context) {
    curretIndex = 2;
    isFloatingActionButtonShown = false;
    emit(ChangeIndexToMaychCartScreen());
  }

//====to hide floating action button in cart screen
  bool isFloatingActionButtonShown = true;
  //========Bottom navigation bar logic==========
  int curretIndex = 0;
  void changeBottomNavIndex(int index) {
    curretIndex = index;

    if (curretIndex == 1) {
      getFavourites(userId!);
    }
    if (curretIndex == 2) {
      isFloatingActionButtonShown = false;
      // CartCubit.get(context!).getCartProducts();
      emit(ChangeIndexToMaychCartScreen());
    } else {
      isFloatingActionButtonShown = true;
    }

    emit(ShopChangeBottomNavBar());
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'الرئيسية',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'المفضلة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'عربة التسوق',
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
