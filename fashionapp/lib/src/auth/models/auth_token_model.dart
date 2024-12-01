import 'dart:convert';

AccessTokenModel accessTokenModelFromJson(String str) =>
    AccessTokenModel.fromJson(json.decode(str));

String accessTokenModelToJson(AccessTokenModel data) =>
    json.encode(data.toJson());

class AccessTokenModel {
  final String authToken;

  AccessTokenModel({
    required this.authToken,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      AccessTokenModel(
        authToken: json["auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
      };
}
