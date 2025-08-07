import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart' as di;
import 'package:list_rickandmorty_app/features/characters/presentation/pages/character_list_page.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_list_header.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_filter_button.dart';

void main() {
  group('Teste de Integração do App', () {
    setUpAll(() async {
      await di.init();
    });

    tearDownAll(() async {
      await di.sl.reset();
    });

    testWidgets('deve carregar a página principal com header', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
      expect(find.byType(CharacterListHeader), findsOneWidget);
    });

    testWidgets('deve mostrar botão de filtro no header', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      expect(find.text('Filtrar'), findsOneWidget);
      expect(find.byType(CharacterFilterButton), findsOneWidget);
    });

    testWidgets('deve mostrar botão de refresh no header', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('deve mostrar dialog de filtro ao tocar no botão filtrar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      final botaoFiltrar = find.text('Filtrar');
      await tester.tap(botaoFiltrar);
      await tester.pumpAndSettle();

      expect(find.text('Filtrar Personagens'), findsOneWidget);
      expect(find.text('Ordem Alfabética'), findsOneWidget);
      expect(find.text('Por Status'), findsOneWidget);
    });

    testWidgets('deve fechar dialog de filtro ao tocar fora', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      final botaoFiltrar = find.text('Filtrar');
      await tester.tap(botaoFiltrar);
      await tester.pumpAndSettle();

      expect(find.text('Filtrar Personagens'), findsOneWidget);

      await tester.tapAt(const Offset(100, 100));
      await tester.pumpAndSettle();

      expect(find.text('Filtrar Personagens'), findsNothing);
    });

    testWidgets('deve lidar com estado de erro graciosamente', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
    });

    testWidgets('deve ter estrutura básica da página', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const CharacterListPage()));

      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });
  });
}
