import 'package:fashionapp/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';

class FetchNotifications {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchNotifications({
    required this.notifications,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
