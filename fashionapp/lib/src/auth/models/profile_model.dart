import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String email;
  final int id;
  final String username;

  ProfileModel({
    required this.email,
    required this.id,
    required this.username,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json["email"],
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "username": username,
      };
}
