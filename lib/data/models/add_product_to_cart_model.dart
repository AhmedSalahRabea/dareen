class AddProductToCartModel {
  final String message;
  final bool status;

  AddProductToCartModel({
    required this.message,
    required this.status,
  });
  factory AddProductToCartModel.fromJson(Map<String, dynamic> jsonData) {
    return AddProductToCartModel(
      message: jsonData['message'],
      status: jsonData['status'],
    );
  }
}
