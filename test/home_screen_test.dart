import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_front/screens/home_screen.dart'; // Altere para o caminho correto do seu arquivo

void main() {
  testWidgets('HomeScreen displays title and logout button',
      (WidgetTester tester) async {
    // Cria a aplicação com a HomeScreen, passando um valor de exemplo para responseData
    await tester.pumpWidget(
        MaterialApp(home: HomeScreen(responseData: 'User Data Example')));

    // Verifica se o título está sendo exibido
    expect(find.text('Home Screen'), findsOneWidget);

    // Verifica se o ícone do menu está presente na AppBar
    expect(find.byIcon(Icons.menu),
        findsOneWidget); // Certifique-se de que este ícone é o que está na HomeScreen

    // Tenta clicar no ícone do menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(); // Aguarda a animação do Drawer abrir

    // Verifica se o botão de logout está sendo exibido no Drawer
    expect(find.text('Logout'), findsOneWidget);

    // Tenta clicar no botão de logout
    await tester.tap(find.text('Logout'));
    await tester
        .pumpAndSettle(); // Aguarda qualquer animação ou mudança de estado
  });
}
