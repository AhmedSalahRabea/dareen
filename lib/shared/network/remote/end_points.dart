// ignore_for_file: constant_identifier_names, avoid_print

import 'package:dareen_app/shared/network/local/cache_helper.dart';

const String LOGIN = 'client/login';
const String REGISTER = 'client/register';
const String CATEGORIES = 'all/categories';
const String CATEGORYPRODUCTS = 'get/products';
const String FAVOURITES = 'get/favorites';
const String ADDORDELETEFAVOURITE = 'add/favorites';
const String SEARCH = 'search/product';



//token
String? token = CacheHelper.getDataFromSharedPrefrences(key: 'token');
int? userId = CacheHelper.getDataFromSharedPrefrences(key: 'userId');
String? userName = CacheHelper.getDataFromSharedPrefrences(key: 'userName');
String? phoneNumber =
    CacheHelper.getDataFromSharedPrefrences(key: 'phoneNumber');
String? userRegion = CacheHelper.getDataFromSharedPrefrences(key: 'userRegion');
String? userAddress =
    CacheHelper.getDataFromSharedPrefrences(key: 'userAddress');

//=== method called when make register or login ===
void saveUserDataInSharedPref({
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
}

//===== delete user data when logout===
void deleteUserDataWhenLogout() async {
  await CacheHelper.removeDataFromSharedPrefrence(key: 'token');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'uId');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userName');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'phoneNumber');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userRegion');
  await CacheHelper.removeDataFromSharedPrefrence(key: 'userAddress');
  print(
      'all userData deleted and user name now is ${await CacheHelper.getDataFromSharedPrefrences(key: 'userName')}');
}
