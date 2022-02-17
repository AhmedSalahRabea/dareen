import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
       // baseUrl: 'https://container.ae.org/api/',
       baseUrl: 'https://dareen.com.container.ae.org/api/',
        receiveDataWhenStatusError: true,
        //connectTimeout: 30000, // 30 seconds
        // receiveTimeout: 30000,
      ),
    );
  }

//=====this method to get data from my api=========
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'lang': lang,
    //   'Authorization': token ?? '',
    // };
    return await dio.get(
      url,
      queryParameters: query ?? {},
    );
  }

//=====this method to post data to my api=========
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'lang': lang,
    //   'Authorization': token ?? '',
    // };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  //=====this method to update data to my api=========
  static Future<Response> updateData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  //=====this method to delte data from my api=========
  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'lang': lang,
    //   'Authorization': token ?? '',
    // };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
