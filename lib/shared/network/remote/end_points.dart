// ignore_for_file: constant_identifier_names, avoid_print

import 'package:dareen_app/shared/network/local/cache_helper.dart';

//end points
const String LOGIN = 'client/login';
const String REGISTER = 'client/register';
const String CATEGORIES = 'all/categories';
const String CATEGORYPRODUCTS = 'get/products';
const String FAVOURITES = 'get/favorites';
const String ADDORDELETEFAVOURITE = 'add/favorites';
const String SEARCH = 'search/product';
const String UPDATEUSERDATA = 'client/edit/profile';
const String GETCARTPRODUCTS = 'get/Product/From/Cart';
const String ADDPRODUCTTOCART = 'add/new/cart';
const String DELETEPRODUCTFROMCART = 'delete/product/cart';
const String GETALLPRODUCTS = 'get/all/products';
const String CHANGEPASSWORD = 'client/update/password';




//user Data
String? token = CacheHelper.getDataFromSharedPrefrences(key: 'token');
int? userId = CacheHelper.getDataFromSharedPrefrences(key: 'userId');
String? userName = CacheHelper.getDataFromSharedPrefrences(key: 'userName');
String? phoneNumber =
    CacheHelper.getDataFromSharedPrefrences(key: 'phoneNumber');
String? userRegion = CacheHelper.getDataFromSharedPrefrences(key: 'userRegion');
String? userAddress =
    CacheHelper.getDataFromSharedPrefrences(key: 'userAddress');

//=== method called when make register or login ===
Future<void> saveUserDataInSharedPref({
  required String token,
  required int userId,
  required String userName,
  required String phoneNumber,
  required String userRegion,
  required String userAddress,
}) async {
  await CacheHelper.saveDataInSharedPrefrences(key: 'token', value: token);
  await CacheHelper.saveDataInSharedPrefrences(key: 'userId', value: userId);

  await CacheHelper.saveDataInSharedPrefrences(
      key: 'userName', value: userName);

  await CacheHelper.saveDataInSharedPrefrences(
      key: 'phoneNumber', value: phoneNumber);
  await CacheHelper.saveDataInSharedPrefrences(
      key: 'userRegion', value: userRegion);
  await CacheHelper.saveDataInSharedPrefrences(
      key: 'userAddress', value: userAddress);
  print(await CacheHelper.getDataFromSharedPrefrences(key: 'userName'));
  print(await CacheHelper.getDataFromSharedPrefrences(key: 'userId'));
  print(await CacheHelper.getDataFromSharedPrefrences(key: 'phoneNumber'));
  print(await CacheHelper.getDataFromSharedPrefrences(key: 'token'));
}

//===== delete user data when logout===
Future<void> deleteUserDataWhenLogout() async {
  await CacheHelper.removeDataFromSharedPrefrence(key: 'token');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userId');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userName');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'phoneNumber');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userRegion');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userAddress');
  print(
      'all userData deleted and userId now is ${await CacheHelper.getDataFromSharedPrefrences(key: 'userId')}');
  print(
      'all userData deleted and token now is ${await CacheHelper.getDataFromSharedPrefrences(key: 'token')}');
}
