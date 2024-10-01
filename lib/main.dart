import 'package:flutter/material.dart';
import 'package:flutter_front/screens/login_screen.dart';
import 'package:flutter_front/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Certifique-se de que o Flutter foi inicializado antes de carregar o dotenv
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variáveis de ambiente
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(
              responseData:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
        //Rotas adicionais podem ser adicionadas aqui
      },
    );
  }
}
