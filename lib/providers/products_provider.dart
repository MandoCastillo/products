import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productos/models/product_model.dart';
import 'package:productos/share_prefs/user_preferences.dart';
import 'package:productos/utils/const.dart';

class ProductsProvider {
  final _url = '${Const.baseUrlApi}/products';
  final _userPreferences = UserPreferences();

  Future<List<Product>> getProducts() async {
    final _endpoint = Uri.parse('$_url.json?auth=${_userPreferences.token}');

    final response = await http.get(_endpoint);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    if (decodeData == null) return [];

    final List<Product> products = [];

    decodeData.forEach((key, value) {
      final prodTemp = Product.fromJson(value);
      prodTemp.id = key;
      products.add(prodTemp);
    });

    return products;
  }

  Future<Product> addProduct(Product product) async {
    final _endpoint = Uri.parse('$_url.json?auth=${_userPreferences.token}');
    final response = await http.post(_endpoint, body: productToJson(product));
    final decodeData = json.decode(response.body);
    // print(decodeData);
    return product.copyWith(id: decodeData['name']);
  }
}
