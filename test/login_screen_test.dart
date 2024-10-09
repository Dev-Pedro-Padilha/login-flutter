import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_front/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen displays form and validates input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Verifique se os campos de entrada estão sendo exibidos
    expect(find.byType(TextField),
        findsNWidgets(2)); // Supondo que haja 2 campos (usuário e senha)

    // Verifique se o botão de login está presente
    expect(find.text('Login'), findsOneWidget);

    // Preencha os campos
    await tester.enterText(find.byType(TextField).first, 'username');
    await tester.enterText(find.byType(TextField).last, 'password');

    // Clique no botão de login
    await tester.tap(find.text('Login'));

    // Aguardar a execução da ação
    await tester.pumpAndSettle();

    // Aqui você pode verificar se a navegação ocorreu ou outra lógica
  });
}
