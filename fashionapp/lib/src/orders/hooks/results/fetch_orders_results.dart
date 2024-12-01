import 'package:fashionapp/src/orders/models/orders_model.dart';
import 'package:flutter/material.dart';

class FetchOrders {
  final List<OrdersModel> orders;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrders(
      {required this.orders,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
