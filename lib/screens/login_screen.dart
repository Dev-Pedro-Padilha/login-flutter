import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/auth_service.dart';
import 'package:flutter_front/utils/dialog_utils.dart';

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
      //Verifica Departamento e Cargo do Usuario
      final department = response['user']['isDepartmentValid'];
      final cargo = response['user']['isCargoValid'];
      //print(department + '\n' + cargo);

      if (department == true && cargo == true) {
        //print('Departamento e Cargo ok');
        // Navegação para outra tela após sucesso
        final responseData = jsonEncode(response);

        Navigator.pushReplacementNamed(context, '/home',
            arguments: responseData);
      } else {
        // Chama a função de popup de erro que agora está no arquivo utilitário
        await showErrorDialog(context, 'Cadastro Incorreto.');
      }
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
      backgroundColor: const Color.fromARGB(255, 235, 237, 245),
      body: Stack(
        children: [
          //Imagem de fundo
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fill,
          ))),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_perto_m.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 100),
                  Text(
                    'Bem-vindo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.black, width: 0.1),
                      ),
                      //Adiciona borda ao compo de texto
                      labelText: 'Usuário', //Rotulo do campo de texto
                      hintText:
                          'Digite seu usuario', //Texto de dica dentro do campo
                    ),
                  ),
                  SizedBox(
                      height: 30), //Espaço entre o campo de usuário e senha
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.black, width: 0.1),
                      ), //Adiciona borda ao compo de texto
                      labelText: 'Senha', //Rotulo do campo de texto
                      hintText:
                          'Digite sua senha', //Texto de dica dentro do campo
                    ),
                    obscureText: true, //Esconde o texto digitado
                  ),
                  SizedBox(height: 80),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 26, 128, 229),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 135, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
