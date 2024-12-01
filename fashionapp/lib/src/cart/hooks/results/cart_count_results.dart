import 'package:fashionapp/src/cart/models/cart_count_model.dart';
import 'package:flutter/material.dart';

class FetchCartCount {
  final CartCountModel count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCartCount({
    required this.count,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
