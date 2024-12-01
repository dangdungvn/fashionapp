import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';

class FetchCart {
  final List<CartModel> cart;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCart({
    required this.cart,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
