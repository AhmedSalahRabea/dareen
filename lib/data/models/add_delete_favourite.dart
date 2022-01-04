class AddOrDeleteProductFromFavouritesModel {
  final String message;
  final bool status;

  AddOrDeleteProductFromFavouritesModel({
    required this.message,
    required this.status,
  });
  factory AddOrDeleteProductFromFavouritesModel.fromJson(
      Map<String, dynamic> jsonData) {
    return AddOrDeleteProductFromFavouritesModel(
      message: jsonData['message'],
      status: jsonData['status'],
    );
  }
}
