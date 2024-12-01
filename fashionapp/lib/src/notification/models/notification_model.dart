import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final DateTime updatedAt;
  final int orderId;
  final int userId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    required this.updatedAt,
    required this.orderId,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        isRead: json["isRead"],
        updatedAt: DateTime.parse(json["updated_at"]),
        orderId: json["orderId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "isRead": isRead,
        "updated_at": updatedAt.toIso8601String(),
        "orderId": orderId,
        "userId": userId,
      };
}
