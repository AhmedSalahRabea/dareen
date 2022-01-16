// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:dareen_app/data/models/add_product_to_cart_model.dart';
import 'package:dareen_app/data/models/cart_model.dart';
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
      if (cartModel!.status!) {
        if (cartModel!.data != null) {
          cartModel!.data!.forEach((element) {
            cartProducts.add(element);
            cartDetails.addAll({
              element.productModel.id: {
                'quantity': element.quantity,
                'totalPrice':
                    '${(element.productModel.newPrice ?? element.productModel.price)! * element.quantity}',
              },
            });
            print('now ============ $cartDetails');
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

  //=== the total of price to all products ====
  // int get totalPrice =>
  //     cartProducts.fold(0, (previousValue, element) => previousValue +element.productModel.newPrice!);

//====== to add product to cart ========
  AddOrDeleteProductToCartModel? addProductToCartModel;
  void addProductToCart({
    required int productId,
    required BuildContext context,
  }) async {
    // getCartProducts();
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
        addProductToCartModel =
            AddOrDeleteProductToCartModel.fromJson(value.data);
        if (addProductToCartModel!.status) {
          getCartProducts();
          mySnackBar(
              context: context,
              content: 'تم إضافة المنتج إلي عربة التسوق الخاصة بكم ');

          emit(AddProductToCartSuccess());
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
  AddOrDeleteProductToCartModel? deleteProductFromCartModel;
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
      deleteProductFromCartModel =
          AddOrDeleteProductToCartModel.fromJson(value.data);
      if (deleteProductFromCartModel!.status) {
        getCartProducts();
        cartDetails.remove(productId);
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

    // int quantity = 1;
    // void increaseQuantity() {
    //   quantity += 1;
    //   emit(IncreaseQuantity());
    // }

    // void decreaseQuantity() {
    //   if (quantity > 1) {
    //     quantity -= 1;
    //     emit(DecreaseQuantity());
    //   }
    // }
  }

  Map<int, dynamic> cartDetails = {
    // 00: {
    //   'quantity': 3,
    //   'totalPrice': 45,
    // },
  };
  double totalPrice = 0;
  void totalPriceFunction() {
    cartDetails.forEach((key, value) {
      totalPrice = totalPrice  + (value['quantity']*value['totalPrice']) ;
    });
    emit(TotalPriceChanged());
  }
}
