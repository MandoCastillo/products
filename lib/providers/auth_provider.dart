import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productos/utils/const.dart';

class AuthProvider {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final _endpoint = Uri.parse(
        '${Const.baseUrlAuth}:signInWithPassword?key=AIzaSyD2kJhAdZWKo1Zy_FWQ8LBE_-9bfrW1eOc');
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(_endpoint, body: jsonEncode(authData));

    final Map<String, dynamic> decodeResponse = jsonDecode(response.body);

    if (decodeResponse.containsKey('idToken')) {
      return {
        'ok': true,
        'token': decodeResponse['idToken'],
        'email': decodeResponse['email']
      };
    }
    return {'ok': false, 'message': decodeResponse['error']['message']};
  }
}
