import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      // Navegação para outra tela após sucesso
      final responseData = jsonEncode(response);
      print(response);
      Navigator.pushReplacementNamed(context, '/home', arguments: responseData);
    } catch (error) {
      setState(() {
        _errorMessage = 'Login falhou. Verifique suas credenciais.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(), //Adiciona borda ao compo de texto
                labelText: 'Usuário', //Rotulo do campo de texto
                hintText: 'Digite seu usuario', //Texto de dica dentro do campo
              ),
            ),
            SizedBox(height: 20), //Espaço entre o campo de usuário e senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(), //Adiciona borda ao compo de texto
                labelText: 'Senha', //Rotulo do campo de texto
                hintText: 'Digite sua senha', //Texto de dica dentro do campo
              ),
              obscureText: true, //Esconde o texto digitado
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
          ],
        ),
      ),
    );
  }
}
