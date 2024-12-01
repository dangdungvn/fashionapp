import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  final String password;
  final String username;
  final String email;

  RegistrationModel({
    required this.password,
    required this.username,
    required this.email,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        password: json["password"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
        "email": email,
      };
}
