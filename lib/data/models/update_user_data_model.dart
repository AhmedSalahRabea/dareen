
class UpdateUserDataModel {
  final String message;
  final bool status;

  UpdateUserDataModel({
    required this.message,
    required this.status,
  });
  factory UpdateUserDataModel.fromJson(Map<String, dynamic> jsonData) {
    return UpdateUserDataModel(
      message: jsonData['message'],
      status: jsonData['status'],
    );
  }
}
