class SuccessOrFailedModel {
  String? message;
  bool? status;

  SuccessOrFailedModel({
    this.message,
    this.status,
  });

  SuccessOrFailedModel.fromJson(Map<String, dynamic> jsonData) {
    message = jsonData['message'];
    status = jsonData['status'];
  
  }
}