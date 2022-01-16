class ChangePasswordModel {
  String? message;
  bool? status;

  ChangePasswordModel({
    this.message,
    this.status,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> jsonData) {
    message = jsonData['message'];
    status = jsonData['status'];
  
  }
}