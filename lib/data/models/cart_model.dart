import 'package:dareen_app/data/models/product_model.dart';

class CartModel {
  String? message;
  bool? status;
  List<CartItemData>? data = [];

  CartModel.fromJson(Map<String, dynamic> jsonData) {
    message = jsonData['message'];
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      jsonData['data'].forEach((element) {
        data!.add(CartItemData.fromJson(element));
      });
    }
  }
}

class CartItemData {
  final int id;
  final int cartId;
  final int productId;
   int quantity;
  final int totalPrice;
  final ProductModel productModel;

  CartItemData({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.productModel,
  });

  factory CartItemData.fromJson(Map<String, dynamic> jsonData) {
    return CartItemData(
      id: jsonData['id'],
      cartId: jsonData['cart_id'],
      productId: jsonData['product_id'],
      quantity: jsonData['qty'],
      totalPrice: jsonData['total_price'],
      productModel: ProductModel.fromJson(jsonData['product']),
    );
  }
}
