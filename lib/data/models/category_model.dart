
class CategoriesModel {
  List<CategoryModel>? data = [];
  String? message;
  bool? status;

  CategoriesModel.fromJson(Map<String, dynamic> jsonData) {
    jsonData['data'].forEach((element) {
      data!.add(CategoryModel.fromJson(element));
    });

    message = jsonData['message'];
    status = jsonData['status'];
  }
}

class CategoryModel {
  final int id;
  final String image;
  final String name;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> jaonData) {
    return CategoryModel(
      id: jaonData['id'],
      image: jaonData['image'],
      name: jaonData['name'],
    );
  }
}
