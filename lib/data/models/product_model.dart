class ProductsModel {
  List<ProductModel>? data =[];
  String? message;
  bool? status;

  ProductsModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] !=null) {
        jsonData['data'].forEach((element) {
      data!.add(ProductModel.fromJson(element));
    });
    }
  

    message = jsonData['message'];
    status = jsonData['status'];
  }
}

class ProductModel {
  final int id;
  final String name;
  final List<dynamic> images;
  final String? desc;
  final String? offer;
  final num? price;
  final num? newPrice;
  final int categoryId;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.images,
    this.desc,
    this.offer,
    this.price,
    this.newPrice,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jaonData) {
    return ProductModel(
      id: jaonData['id'],
      name: jaonData['name'],
      images: jaonData['image'],
      desc: jaonData['desc'],
      offer: jaonData['offer'],
      price: jaonData['price'],
      newPrice: jaonData['new_price'],
      categoryId: jaonData['category_id'],
      createdAt: jaonData['created_at'],
      updatedAt: jaonData['updated_at'],
    );
  }
}
