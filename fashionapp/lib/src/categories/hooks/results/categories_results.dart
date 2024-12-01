import 'package:fashionapp/src/categories/models/categories_model.dart';
import 'package:flutter/material.dart';

class FetchCategories {
  final List<Categories> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCategories({
    required this.categories,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
