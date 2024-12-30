import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/orders/hooks/results/fetch_orders_results.dart';
import 'package:fashionapp/src/orders/models/orders_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchOrders fetchOrders(FetchOrdersTypes o) {
  final orders = useState<List<OrdersModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Uri url = Uri.parse("");
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      switch (o) {
        case FetchOrdersTypes.pending:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=Pending');
          break;
        case FetchOrdersTypes.delivered:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=delivered');
          break;
        case FetchOrdersTypes.cancelled:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=cancelled');
          break;
      }
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        orders.value = ordersModelFromJson(utf8.decode(response.bodyBytes));
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
  }, [o.index]);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchOrders(
      orders: orders.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
