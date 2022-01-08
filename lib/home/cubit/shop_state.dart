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

//=== when get favourite products for a particular user===
class FavouritesLoading extends ShopState {}

class FavouritesGetSuccess extends ShopState {}

class FavouritesGetError extends ShopState {}

//=== when add or delete product from favourites===
class AddOrDeleteFavouriteLoading extends ShopState {}

class AddOrDeleteFavouriteSuccess extends ShopState {}

class AddOrDeleteFavouriteError extends ShopState {}
//===to determine like button  color===
class LikeButtonColorChanged extends ShopState {}

class ChangeIndexToMaychCartScreen extends ShopState {}
//======when the user click back button from products screenr=====
class MakeProductsModelEmpty extends ShopState {}

//======when change in bottom navigation bar=====
class ShopChangeBottomNavBar extends ShopState {}
