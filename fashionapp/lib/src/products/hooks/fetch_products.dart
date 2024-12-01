import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/categories/hooks/results/category_products_results.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;
    try {
      if (queryType == QueryType.all) {
        url = Uri.parse('${Environment.appBaseUrl}/api/products/');
      } else if (queryType == QueryType.popular) {
        url = Uri.parse('${Environment.appBaseUrl}/api/products/popular/');
      } else if (queryType == QueryType.unisex ||
          queryType == QueryType.men ||
          queryType == QueryType.women ||
          queryType == QueryType.kids) {
        url = Uri.parse(
            '${Environment.appBaseUrl}/api/products/byType/?clothesType=${queryType.name}');
      } else {
        throw Exception("Unsupported query type: $queryType");
      }

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        products.value = productsFromJson(utf8.decode(response.bodyBytes));
      } else {
        error.value = 'Failed to fetch data: ${response.statusCode}';
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
  }, [queryType.index]);

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
