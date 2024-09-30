import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //Importa a biblioteca http
import 'dart:convert'; //Importa para usar jsonEncode
import 'home_screen.dart'; //Importa a nova tela
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Função principal que inicia o aplicativo
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

// Classe que representa o aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela em Branco', // Título do aplicativo
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minha Tela em Branco'), // Título da barra de aplicativos
        ),
        body: Padding(
          padding: const EdgeInsets.all(
              16.0), // Adiciona espaçamento em volta do conteúdo
          child: MyForm(), // Adiciona o formulário que criamos
        ),
      ),
    );
  }
}

// Classe que representa o formulário, usa StatefulWidget para manter o estado
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState(); // Cria o estado do formulário
}

// Estado do MyForm
class _MyFormState extends State<MyForm> {
  // Controladores para os campos de texto
  final TextEditingController _username =
      TextEditingController(); // Controlador para o campo de usuário
  final TextEditingController _password =
      TextEditingController(); // Controlador para o campo de senha

  //Função para enviar os dados para a API
  Future<void> _submitData() async {
    final usernameText = _username.text;
    final passwordText = _password.text;

    final url = Uri.parse(
        '${dotenv.env['API_URL']}/auth/login'); // IP correto para o emulador

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "username": usernameText,
          "password": passwordText,
        }),
      );

      if (response.statusCode == 201) {
        // Se a requisição for bem-sucedida, mostre a resposta
        final responseData = json.decode(response.body);
        //print(responseData);
        final message = responseData['message'];
        final user = responseData['user'];
        //print('User:$user');
        final token = responseData['token'];

        // Exibir os dados do usuário ou fazer algo com eles
        //print('Mensagem: $message');
        //print('Usuário: ${user['cn']}');
        //print('Token: $token');

        //Agora faz a requisição para a tela home
        final newUrl = Uri.parse('${dotenv.env['API_URL']}/home');
        final newResponse = await http.post(
          newUrl,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          //body: json.encode(responseData),
        );
        //print('Response Data: $responseData');

        if (newResponse.statusCode == 201) {
          //Navega para a nova tela passando a resposta

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                responseData: json.encode(responseData),
              ),
            ),
          );
        } else {
          //Se a requisição falhar
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Erro!'),
              content: Text(
                  'Falha ao conectar à API no segundo endpoint. Código: ${newResponse.statusCode}'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          );
        }
      } else {
        // Se a requisição falhar, mostre um erro
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Erro!'),
            content:
                Text('Falha ao conectar à API. Código: ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Se a requisição de login falhar, mostre um erro
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro!'),
          content: Text('Erro de conexão: $error'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  // Função que constrói a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login:', // Texto que indica que se trata da seção de login
          style: TextStyle(fontSize: 20), // Estilo do texto
        ),
        SizedBox(height: 20), // Espaço entre o texto e o campo de entrada
        TextField(
          controller: _username, // Conecta o controlador ao campo de texto
          decoration: InputDecoration(
            border: OutlineInputBorder(), // Adiciona borda ao campo de texto
            labelText: 'Username', // Rótulo do campo de texto
            hintText: 'Digite seu usuario', // Texto de dica dentro do campo
          ),
        ),
        SizedBox(
            height: 20), // Espaço entre o campo de usuário e o campo de senha
        TextField(
          controller: _password, // Conecta o controlador ao campo de senha
          decoration: InputDecoration(
            border: OutlineInputBorder(), // Adiciona borda ao campo de texto
            labelText: 'Password', // Rótulo do campo de texto
            hintText: 'Digite sua senha', // Texto de dica dentro do campo
          ),
          obscureText: true, // Esconde o texto digitado (útil para senhas)
        ),
        SizedBox(height: 20), // Espaço entre o campo de senha e o botão
        ElevatedButton(
          onPressed:
              _submitData, // Chama a função _submitData ao pressionar o botão
          child: Text('Login'), // Texto do botão
        ),
      ],
    );
  }
}
