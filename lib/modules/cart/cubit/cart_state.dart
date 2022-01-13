part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
//===states when get products to cart
class GetCartLoading extends CartState {}
class GetCartSuccess extends CartState {}
class GetCartError extends CartState {}
//===states when add a product to cart
class AddProductToCartLoading extends CartState {}
class AddProductToCartSuccess extends CartState {}
class AddProductToCartError extends CartState {}

//===states when delete a product from cart
class DeleteProductFromCartLoading extends CartState {}
class DeleteProductFromCartSuccess extends CartState {}
class DeleteProductFromCartError extends CartState {}

//======== increase and decrease quantity =======
class IncreaseQuantity extends CartState {}
class DecreaseQuantity extends CartState {}



