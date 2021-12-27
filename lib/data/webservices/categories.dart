// ignore_for_file: avoid_print

import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dio/dio.dart';

class CategoriesWebServices {
  Future<dynamic> getAllCategories() async {
    Response response = await DioHelper.getData(url: CATEGORIES);
    try {
      return response.data;
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}
