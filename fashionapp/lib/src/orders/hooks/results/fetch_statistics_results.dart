import 'package:flutter/material.dart';

class FetchStatistics {
  final Map<String, int> statistics;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchStatistics(
      {required this.statistics,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
