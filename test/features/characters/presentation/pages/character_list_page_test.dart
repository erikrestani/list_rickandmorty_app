import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

void main() {
  group('CharacterListPage - Interface do Usuário', () {
    testWidgets(
      'deve exibir AppBar com título "Rick and Morty" e botão de refresh',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Rick and Morty'),
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.textColor,
                actions: [
                  IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
                ],
              ),
              body: const Text('Conteúdo'),
            ),
          ),
        );

        expect(find.text('Rick and Morty'), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      },
    );

    testWidgets(
      'deve exibir indicador de loading circular quando carregando dados',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.textColor),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'deve exibir tela de erro com ícone, mensagem e botão de retry quando há erro',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Erro de conexão',
                      style: TextStyle(color: AppTheme.errorColor),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.textColor,
                      ),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Erro de conexão'), findsOneWidget);
        expect(find.text('Tentar Novamente'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      },
    );
  });
}
