import 'dart:convert';

import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/categories/hooks/results/categories_results.dart';
import 'package:fashionapp/src/categories/models/categories_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCategories fetchHomeCategories() {
  final categories = useState<List<Categories>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final isMounted = useIsMounted();

  Future<void> fetchData() async {
    if (!isMounted()) return;
    isLoading.value = true;
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/products/categories/home/');

      final response = await http.get(url);

      if (!isMounted()) return;
      if (response.statusCode == 200) {
        categories.value = categoriesFromJson(utf8.decode(response.bodyBytes));
      } else {}
    } catch (e) {
      if (!isMounted()) return;
      error.value = e.toString();
    } finally {
      if (isMounted()) {
        isLoading.value = false;
      }
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

  return FetchCategories(
      categories: categories.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
