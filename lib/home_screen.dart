import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart';
import 'dart:typed_data';

class HomeScreen extends StatelessWidget {
  final String responseData; // Armazena a resposta da API em formato JSON

  // Construtor da classe HomeScreen, que recebe a resposta da API
  HomeScreen({required this.responseData});

  // Função de logout
  void logout(BuildContext context) async {
    // Reinicia a aplicação chamando o main.dart
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Decodifica a resposta JSON para um objeto Dart
    final user = json.decode(responseData);
    print(user);

    //Verifica se existe uma imagem base64 disponivel no JSON
    final base64Image = user['imageBase64'];
    final Uint8List? imageBytes =
        base64Image != null ? base64Decode(base64Image) : null;
    print('Imagem:${base64Image}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'), // Título da AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.menu), // Ícone do menu
            onPressed: () {
              Scaffold.of(context)
                  .openDrawer(); // Abre o drawer ao clicar no ícone
            },
          ),
        ],
      ),
      // Drawer que contém as opções do menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu', // Título do cabeçalho do drawer
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // Cor de fundo do cabeçalho
              ),
            ),
            // Opção de logout no menu
            ListTile(
              title: Text('Logout'),
              onTap: () {
                logout(context); // Chama a função de logout ao clicar
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[50], // Cor de fundo da tela
      body: user == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostra um carregando enquanto o usuário não está disponível
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                      20.0), // Padding interno do container
                  width: double
                      .infinity, // Largura do container ocupando todo o espaço disponível
                  decoration: BoxDecoration(
                    color: Colors.blue, // Cor de fundo do container
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Alinha os itens no centro verticalmente
                    children: [
                      ClipOval(
                          child: imageBytes != null
                              ? Image.memory(
                                  imageBytes,
                                  width: 50.0, // Largura da imagem
                                  height: 50.0, // Altura da imagem
                                  fit: BoxFit
                                      .cover, // Cobre o espaço do contêiner
                                )
                              : Image.asset(
                                  'assets/images/user.png', // Imagem do usuário
                                  width: 50.0, // Largura da imagem
                                  height: 50.0, // Altura da imagem
                                  fit: BoxFit
                                      .cover, // Cobre o espaço do contêiner
                                )),
                      SizedBox(
                          width: 20.0), // Espaçamento entre a imagem e o texto
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Alinha os textos à esquerda
                        children: [
                          Text(
                            user['user']['cn'],
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Text(
                            user['user']['title'], // Título do usuário
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Text(
                            user['user']
                                ['department'], // Departamento do usuário
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Adicione mais widgets aqui, se necessário
              ],
            ),
    );
  }
}
