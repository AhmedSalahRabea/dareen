//model to save the response of get favourites
import 'package:dareen_app/data/models/product_model.dart';

class FavouritesModel {
  String? message;
  bool? status;
  List<FavouriteDataModel>? data =[];

  FavouritesModel.fromJson(Map<String, dynamic> jsonData) {
    message = jsonData['message'];
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      jsonData['data'].forEach((element) {
        data!.add(FavouriteDataModel.fromJson(element));
      });
    }
  }
}

//model of onr item in list of favourites
class FavouriteDataModel {
  final int id;
  final int userId;
  final int productId;
  final ProductModel product;

  FavouriteDataModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.product,
  });

  factory FavouriteDataModel.fromJson(Map<String, dynamic> jsonData) {
    return FavouriteDataModel(
      id: jsonData['id'],
      userId: jsonData['user_id'],
      productId: jsonData['product_id'],
      product: ProductModel.fromJson(jsonData['product']),
    );
  }
}

//model for single favourite item
// class FavouriteProductModel {
//   final int id;
//   final String name;
//   final String image;
//   final String? desc;
//   final String? offer;
//   final int? price;
//   final int? newPrice;
//   final int categoryId;
//   final String? createdAt;
//   final String? updatedAt;

//   FavouriteProductModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     this.desc,
//     this.offer,
//     this.price,
//     this.newPrice,
//     required this.categoryId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory FavouriteProductModel.fromJson(Map<String, dynamic> jaonData) {
//     return FavouriteProductModel(
//       id: jaonData['id'],
//       name: jaonData['name'],
//       image: jaonData['image'],
//       desc: jaonData['desc'],
//       offer: jaonData['offer'],
//       price: jaonData['price'],
//       newPrice: jaonData['new_price'],
//       categoryId: jaonData['category_id'],
//       createdAt: jaonData['created_at'],
//       updatedAt: jaonData['updated_at'],
//     );
//   }
// }
