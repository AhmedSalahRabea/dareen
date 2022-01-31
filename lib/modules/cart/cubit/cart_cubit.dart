// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:dareen_app/data/models/cart_model.dart';
import 'package:dareen_app/data/models/success_or_failed_model.dart';
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
  //this map to collect data which api need it
  Map<int, Map<String, int>> producIdAndQuantityMap = {};
  //this map to save all total price for each product in the cart then sum them
  Map<int, num> totalPriceForAllProducts = {};
  //this variable
  late num totalPriceForAllProductsInTheCart;
  void getCartProducts() async {
    cartProducts = [];
    producIdAndQuantityMap = {};
    totalPriceForAllProducts = {};
    totalPriceForAllProductsInTheCart = 0;
    emit(GetCartLoading());
    await DioHelper.getData(
      url: GETCARTPRODUCTS,
      query: {
        'user_id': userId,
      },
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (cartModel!.status!) {
        if (cartModel!.data != null) {
          cartModel!.data!.forEach((element) {
            cartProducts.add(element);
            producIdAndQuantityMap.addAll({
              element.productModel.id: {
                'product_id': element.productModel.id,
                'qty': element.quantity,
              }
            });
            totalPriceForAllProducts.addAll({
              element.productModel.id:
                  element.productModel.newPrice ?? element.productModel.price!,
            });
            totalPriceFunction();
            emit(GetCartSuccess());
          });
        }
      } else {
        emit(CartEmptyState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCartError());
    });
  }

//====== to add product to cart ========
  SuccessOrFailedModel? addProductToCartModel;
  void addProductToCart({
    required int productId,
    required BuildContext context,
  }) async {
    emit(AddProductToCartLoading());
    if (cartProducts.any((element) {
          if (element.productModel.id != productId) {
            return false;
          } else {
            return true;
          }
        }) ==
        false) {
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
        addProductToCartModel = SuccessOrFailedModel.fromJson(value.data);
        if (addProductToCartModel!.status!) {
          mySnackBar(
              context: context,
              content: 'تم إضافة المنتج إلي عربة التسوق الخاصة بكم ');
          getCartProducts();
          emit(AddProductToCartSuccess());
        } else {
          mySnackBar(
              context: context,
              content: addProductToCartModel!.message.toString());
          emit(AddProductToCartError());
        }
      }).catchError(
        (error) {
          print(error.toString());
          emit(AddProductToCartError());
        },
      );
    } else {
      mySnackBar(context: context, content: 'المنتج موجود في السلة بالفعل');
      emit(AddProductToCartError());
    }
  }

  //====to delete product from cart ====
  SuccessOrFailedModel? deleteProductFromCartModel;
  void deleteProductFromCart({
    required int cartId,
    required int productId,
    required BuildContext context,
  }) async {
    emit(DeleteProductFromCartLoading());
    await DioHelper.deleteData(url: DELETEPRODUCTFROMCART, data: {
      'cart_id': cartId,
      'product_id': productId,
    }, query: {
      'cart_id': cartId,
      'product_id': productId,
    }).then((value) {
      deleteProductFromCartModel = SuccessOrFailedModel.fromJson(value.data);
      if (deleteProductFromCartModel!.status!) {
        getCartProducts();
        emit(DeleteProductFromCartSuccess());
      }
    }).catchError(
      (error) {
        print(error.toString());
        mySnackBar(
            context: context, content: 'حدث خطأ أثناء حذف المنتج من السلة');
        emit(DeleteProductFromCartError());
      },
    );
  }

//======= to confirm order======
  SuccessOrFailedModel? confirmOrderModel;
  Future<void> confirmOrder({
    required int cartId,
    required List<Map<String, int>> productIdAndQuantity,
  }) async {
    emit(ConfirmOrderLoading());
    // print('===========${producIdAndQuantityMap.values.toList()}');
    await DioHelper.postData(
      url: CONFIRMORDER,
      data: {
        'cart_id': cartId,
        'user_id': userId,
        'products': productIdAndQuantity,
      },
    ).then((value) {
      confirmOrderModel = SuccessOrFailedModel.fromJson(value.data);
      if (confirmOrderModel!.status!) {
        print('========= confirm order done');
        emit(ConfirmOrderSuccess());
      } else {
        print('=========${confirmOrderModel!.message!}');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

//this method to update the tota; price for all products in the cart
  void totalPriceFunction() {
    totalPriceForAllProductsInTheCart = totalPriceForAllProducts.values
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
    // print(
    //     'totalPriceForAllProductsInTheCart $totalPriceForAllProductsInTheCart');
    emit(TotalPriceChanged());
  }
}
