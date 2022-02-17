class ProductsModel {
  List<ProductModel>? data = [];
  String? message;
  bool? status;

  ProductsModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      jsonData['data'].forEach((element) {
        data!.add(ProductModel.fromJson(element));
      });
    }

    message = jsonData['message'];
    status = jsonData['status'];
  }
}

class Images {
  int? id;
  String? image;
  int? productId;

  Images({this.id, this.image, this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    productId = json['product_id'];
  }
}

class ProductModel {
  late int id;
  late String name;
  String? desc;
  String? offer;
  num? price;
  num? newPrice;
  late int categoryId;
  String? createdAt;
  String? updatedAt;
  List<Images>? images = [];

  ProductModel({
    required this.id,
    required this.name,
    this.images,
    this.desc,
    this.offer,
    this.price,
    this.newPrice,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> jaonData) {
    id = jaonData['id'];
    name = jaonData['name'];
    if (jaonData['images'] != null) {
      jaonData['images'].forEach((element) {
        images!.add(Images.fromJson(element));
      });
    }

    desc = jaonData['desc'];
    offer = jaonData['offer'];
    price = jaonData['price'];
    newPrice = jaonData['new_price'];
    categoryId = jaonData['category_id'];
    createdAt = jaonData['created_at'];
    updatedAt = jaonData['updated_at'];
  }
}
