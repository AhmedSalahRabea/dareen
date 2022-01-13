// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:dareen_app/data/models/add_product_to_cart_model.dart';
import 'package:dareen_app/data/models/cart_model.dart';
import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(BuildContext context) => BlocProvider.of(context);

//====== TO get cart items ==========
  CartModel? cartModel;
  List<CartItemData> cartProducts = [];
  void getCartProducts() async {
    cartProducts = [];
    emit(GetCartLoading());
    await DioHelper.getData(
      url: GETCARTPRODUCTS,
      query: {
        'user_id': userId,
      },
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (cartModel!.data != null) {
        cartModel!.data!.forEach((element) {
          cartProducts.add(element);
          emit(GetCartSuccess());
        });
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCartError());
    });
  }

  //to load cart when click on bottom nav bar
  void loadCartItemsWhenClickBottomNavBar(BuildContext? context) {
    if (ShopCubit.get(context).curretIndex == 2) {
      getCartProducts();
    }
  }

//====== to add product to cart ========
  AddProductToCartModel? addProductToCartModel;
  void addProductToCart(
      {required int productId, required BuildContext context}) async {
    emit(AddProductToCartLoading());
    await DioHelper.postData(
      url: ADDPRODUCTTOCART,
      data: {
        'user_id': userId,
        'cart': [
          {
            'product_id': productId,
            'qty': 1,
          },
        ],
      },
    ).then((value) {
      addProductToCartModel = AddProductToCartModel.fromJson(value.data);
      if (addProductToCartModel!.status) {
        mySnackBar(
            context: context,
            content: 'تم إضافة المنتج إلي عربة التسوق الخاصة بكم ');
        emit(AddProductToCartSuccess());
      } else {
        mySnackBar(context: context, content: addProductToCartModel!.message);
        emit(AddProductToCartError());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddProductToCartError());
    });
    // cartProducts.add(product);
    // if (cartProducts.any((element) {
    //       if (element.productId != product.id) {
    //         return false;
    //       } else {
    //         return true;
    //       }
    //     }) ==
    //     false) {
    //   //cartProducts.add(product);
    //   emit(AddProductToCartSuccess());
    // } else {
    //   print('the product already in cart');
    //   emit(AddProductToCartError());
    // }
  }

  // void addProductToCart({required ProductModel product}) {
  //   emit(AddProductToCartLoading());
  //   // cartProducts.add(product);
  //   if (cartProducts.any((element) {
  //         if (element.productId != product.id) {
  //           return false;
  //         } else {
  //           return true;
  //         }
  //       }) ==
  //       false) {
  //     //cartProducts.add(product);
  //     emit(AddProductToCartSuccess());
  //   } else {
  //     print('the product already in cart');
  //     emit(AddProductToCartError());
  //   }
  // }

  //======to delete item from cart ====
  void deleteProductFromCart({required ProductModel product}) {
    emit(DeleteProductFromCartLoading());
    cartProducts.remove(product);
    emit(DeleteProductFromCartSuccess());
  }

  int quantity = 1;
  void increaseQuantity() {
    quantity += 1;
    emit(IncreaseQuantity());
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity -= 1;
      emit(DecreaseQuantity());
    }
  }
}
