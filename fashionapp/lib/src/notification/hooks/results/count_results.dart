import 'package:fashionapp/src/notification/models/notification_count.dart';
import 'package:flutter/material.dart';

class FetchCount {
  final NotificationCount count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCount({
    required this.count,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
