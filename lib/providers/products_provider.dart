import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productos/models/product_model.dart';
import 'package:productos/share_prefs/user_preferences.dart';
import 'package:productos/utils/const.dart';

class ProductsProvider {
  final _userPreferences = UserPreferences();

  Future<List<Product>> getProducts() async {
    final _endpoint = Uri.parse(
        '${Const.baseUrlApi}/products.json?auth=${_userPreferences.token}');

    final response = await http.get(_endpoint);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    if (decodeData == null) return [];

    final List<Product> products = [];

    decodeData.forEach((key, value) {
      final prodTemp = Product.fromJson(value);
      prodTemp.id = key;
      products.add(prodTemp);
    });

    // print(products);

    return products;
  }
}
