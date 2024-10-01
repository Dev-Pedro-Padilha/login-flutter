import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_front/utils/token_manager.dart';
import 'package:flutter_front/constants/api_constants.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse(
        ApiConstants.loginUrl); //Constante definando em api_constants.dart
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      await TokenManager.saveToken(responseData['token']);
      return responseData;
    } else {
      throw Exception('Erro ao fazer Login');
    }
  }
}
