import 'package:fashionapp/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';

class FetchDefaultAddress {
  final AddressModel? address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchDefaultAddress(
      {required this.address,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
