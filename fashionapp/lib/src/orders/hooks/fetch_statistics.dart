import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/orders/hooks/results/fetch_statistics_results.dart';
import 'package:fashionapp/src/orders/models/statistics_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchStatistics fetchStatistics() {
  final statistics = useState<Map<String, int>>({});
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/orders/statistics/');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        statistics.value =
            statisticsModelFromJson(utf8.decode(response.bodyBytes));
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

  return FetchStatistics(
      statistics: statistics.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
