import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter/material.dart';

class FetchProduct {
  final List<Products> products;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchProduct({
    required this.products,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
