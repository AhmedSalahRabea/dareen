import 'product_model.dart';

class SearchModel {
  List<ProductModel>? data = [];
  String? message;
  bool? status;

  SearchModel({
    this.data,
    this.message,
    this.status,
  });

  SearchModel.fromJson(Map<String, dynamic> jsonData) {
    message = jsonData['message'];
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      jsonData['data'].forEach((element) {
        data!.add(ProductModel.fromJson(element));
      });
    }
  }
}
