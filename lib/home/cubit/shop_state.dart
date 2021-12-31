part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

//when get categories from api
class CategoriesGetLoading extends ShopState {}
class CategoriesGetSuccess extends ShopState {}
class CategoriesGetFailed extends ShopState {}

//=== when get products from a particular category===
class ProductsLoading extends ShopState {}
class ProductsGetSuccess extends ShopState {}
class ProductsGetError extends ShopState {}

//======when change in bottom navigation bar=====
class ShopChangeBottomNavBar extends ShopState {}

