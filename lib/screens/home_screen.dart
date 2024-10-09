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

    Uint8List? imageBytes;

    try {
      // Tenta decodificar o responseData para JSON
      final user = json.decode(responseData);

      // Verifica se a chave 'imageBase64' existe no JSON
      final base64Image = user['user']['thumbnailPhoto'];

      if (base64Image != null) {
        try {
          imageBytes = base64Decode(base64Image);
        } catch (e) {
          imageBytes = null;
        }
      }

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 40, 121),
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration:
                  BoxDecoration(color: const Color.fromARGB(255, 17, 40, 121)),
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
                                'assets/images/user.png',
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
                        (user['user']['cn']).toUpperCase() ??
                            'Nome não disponível',
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
            Container(
              width: 375,
              height: 450,
              //padding: const EdgeInsets.all(80.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 237, 245),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset(
                      'assets/images/logo_perto_m.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              logout(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shadowColor: Colors.black,
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Configuração',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              logout(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shadowColor: Colors.black,
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Relatórios',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              logout(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shadowColor: Colors.black,
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Tarefas',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          logout(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shadowColor: Colors.black,
                            elevation: 10,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          logout(context);
                        },
                        child: Text('Home'),
                      ),
                    ),
                  ],
                ),
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
