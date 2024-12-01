import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/addresses/hooks/results/default_results.dart';
import 'package:fashionapp/src/addresses/models/addresses_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchDefaultAddress fetchDefaultAddress() {
  final address = useState<AddressModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  String? accessToken = Storage().getString('accessToken');
  final isMounted = useIsMounted();

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/me');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        address.value = addressModelFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      if (isMounted()) {
        error.value = e.toString();
      }
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    if (accessToken != null) {
      fetchData();
    }
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchDefaultAddress(
      address: address.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
