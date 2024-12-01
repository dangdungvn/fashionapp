import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/notification/controllers/notification_notifier.dart';
import 'package:fashionapp/src/notification/hooks/results/notifications_results.dart';
import 'package:fashionapp/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchNotifications fetchNotifications(BuildContext context) {
  final count = useState<List<NotificationModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/notifications/me/');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        count.value =
            notificationModelFromJson(utf8.decode(response.bodyBytes));
      } else {
        error.value = 'Failed to fetch notifications';
        isLoading.value = false;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  context.read<NotificationNotifier>().setRefetch(refetch);

  return FetchNotifications(
      notifications: count.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
