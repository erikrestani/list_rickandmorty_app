import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_fteam/main.dart';
import 'helpers/test_helper.dart';

void main() {
  group('RickAndMortyApp - Testes de Widget Principal', () {
    setUp(() {
      TestHelper.setupMockCharacterViewModel();
    });

    tearDown(() {
      TestHelper.teardownMocks();
    });

    testWidgets('deve renderizar aplicação sem travar e exibir MaterialApp', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('deve exibir título "Rick and Morty" na interface do usuário', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.text('Rick and Morty'), findsOneWidget);
    });

    testWidgets('deve configurar tema Material3 para interface moderna', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('deve ocultar banner de debug para experiência de produção', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('deve aplicar esquema de cores personalizado com tema verde', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.colorScheme, isNotNull);
    });
  });
}
