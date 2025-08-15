import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/welcome_content.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/load_characters_button.dart';

void main() {
  group('WelcomePage Components', () {
    testWidgets('deve exibir o conteúdo de boas-vindas', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeContent())),
      );

      expect(find.text('Bem Vindo!'), findsOneWidget);
      expect(
        find.text('Explore o universo dos personagens mais loucos da galáxia!'),
        findsOneWidget,
      );
    });

    testWidgets('deve exibir o botão de carregar personagens', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadCharactersButton(isLoading: false, onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Carregar Personagens'), findsOneWidget);
    });
  });
}
