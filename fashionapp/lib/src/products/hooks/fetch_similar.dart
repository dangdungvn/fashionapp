import 'dart:convert';

import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/categories/hooks/results/category_products_results.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchSimilar(int categoryId) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/products/recommendations/?category=$categoryId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        products.value = productsFromJson(utf8.decode(response.bodyBytes));
      } else {}
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

  return FetchProduct(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
