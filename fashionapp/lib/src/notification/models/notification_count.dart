import 'dart:convert';

NotificationCount notificationCountFromJson(String str) =>
    NotificationCount.fromJson(json.decode(str));

String notificationCountToJson(NotificationCount data) =>
    json.encode(data.toJson());

class NotificationCount {
  final int unreadCount;

  NotificationCount({
    required this.unreadCount,
  });

  factory NotificationCount.fromJson(Map<String, dynamic> json) =>
      NotificationCount(
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "unread_count": unreadCount,
      };
}
