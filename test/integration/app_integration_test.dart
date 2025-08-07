import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:list_rickandmorty_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Teste de Integração do App', () {
    testWidgets('deve carregar lista de personagens e exibir personagens', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('deve navegar para detalhes do personagem ao tocar no card', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final primeiroCard = find.byType(InkWell).first;
      await tester.tap(primeiroCard);
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('deve mostrar dialog de filtro ao tocar no botão filtrar', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final botaoFiltrar = find.text('Filtrar');
      await tester.tap(botaoFiltrar);
      await tester.pumpAndSettle();

      expect(find.text('Filtrar Personagens'), findsOneWidget);
      expect(find.text('Ordem Alfabética'), findsOneWidget);
      expect(find.text('Por Status'), findsOneWidget);
    });

    testWidgets('deve atualizar lista ao tocar no botão refresh', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final botaoRefresh = find.byIcon(Icons.refresh);
      await tester.tap(botaoRefresh);
      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('deve lidar com estado de erro graciosamente', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
    });
  });
}
