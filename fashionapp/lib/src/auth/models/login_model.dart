import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String password;
  final String username;

  LoginModel({
    required this.password,
    required this.username,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
      };
}
