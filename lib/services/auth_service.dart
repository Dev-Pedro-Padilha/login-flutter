import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_front/utils/token_manager.dart';
import 'package:flutter_front/constants/api_constants.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse(
        ApiConstants.loginUrl); //Constante definando em api_constants.dart
    //final url = Uri.parse(dotenv.env['API_URL']!);
    try {
      print('Tentando logar no URL: $url');
      print('Enviando dados: {"username": $username, "password": $password}');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      print('Código de resposta: ${response.statusCode}');
      print('Resposta: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Resposta de sucesso: $responseData');
        await TokenManager.saveToken(responseData['token']);
        return responseData;
      } else {
        print('Erro na resposta: ${response.body}');
        throw Exception('Erro ao fazer login: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Erro de autenticação: $error');
    }
  }
}
