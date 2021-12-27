class LoginModel {
  final UserData? data;
  final bool status;
  final String? message;
  final List<dynamic>? error;
  final String? token;
  LoginModel({
    this.data,
    required this.status,
     this.message,
    this.error,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      data: jsonData['data'] != null ? UserData.fromJson(jsonData['data']):null ,
      status: jsonData['status'],
       message: jsonData['message'],
       error: jsonData['error'] ,
       token: jsonData['token'],
       );
  }
}

class UserData {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String region;
  final String address;
  final String image;

  UserData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.region,
    required this.address,
    required this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> jsonData) {
    return UserData(
      id: jsonData['id'],
      name: jsonData['name'],
      phoneNumber: jsonData['phoneNumber'],
      email: jsonData['email'],
      region: jsonData['region'],
      address: jsonData['address'],
      image: jsonData['image'] ?? '',
    );
  }
}
