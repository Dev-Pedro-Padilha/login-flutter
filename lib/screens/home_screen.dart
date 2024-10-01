import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  final String responseData; // Armazena a resposta da API em formato JSON

  // Construtor da classe HomeScreen, que recebe a resposta da API
  HomeScreen({required this.responseData});

  // Função de logout
  void logout(BuildContext context) async {
    // Reinicia a aplicação chamando o main.dart
    // Navegação para outra tela após sucesso
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se o responseData está vazio ou malformado
    if (responseData.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Home Screen')),
        body: Center(child: Text('Nenhum dado recebido.')),
      );
    }

    try {
      // Tenta decodificar o responseData para JSON
      final user = json.decode(responseData);

      // Verifica se a chave 'imageBase64' existe no JSON
      final base64Image = user['imageBase64'];
      final Uint8List? imageBytes =
          base64Image != null ? base64Decode(base64Image) : null;

      return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue[50],
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: imageBytes != null
                        ? Image.memory(
                            imageBytes,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            dotenv.env['DEFAULT_PHOTO'] ??
                                'assets/images/default_photo.png',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['user']['cn'] ?? 'Nome não disponível',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Text(
                        user['user']['title'] ?? 'Título não disponível',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Text(
                        user['user']['department'] ??
                            'Departamento não disponível',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return Scaffold(
        appBar: AppBar(title: Text('Home Screen')),
        body: Center(child: Text('Erro ao processar os dados: $e')),
      );
    }
  }
}
