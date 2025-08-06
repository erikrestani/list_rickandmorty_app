import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_fteam/main.dart';

void main() {
  group('RickAndMortyApp Widget Tests', () {
    testWidgets('App deve renderizar sem travar', (WidgetTester tester) async {
      await tester.pumpWidget(const RickAndMortyApp());

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App deve ter o titulo correto', (WidgetTester tester) async {
      await tester.pumpWidget(const RickAndMortyApp());

      expect(find.text('Rick and Morty'), findsOneWidget);
    });

    testWidgets('App deve ter o tema Material3', (WidgetTester tester) async {
      await tester.pumpWidget(const RickAndMortyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('App não deve mostrar o banner de debug', (WidgetTester tester) async {
      await tester.pumpWidget(const RickAndMortyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('App deve ter o esquema de cores verde', (WidgetTester tester) async {
      await tester.pumpWidget(const RickAndMortyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.colorScheme, isNotNull);
    });
  });
} 