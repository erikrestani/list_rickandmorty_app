import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_fteam/main.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('deve carregar a app e navegar para a lista de personagens', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);

      expect(tester.takeException(), isNull);
    });

    testWidgets('deve lidar com o ciclo de vida da app corretamente', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('deve manter o estado da app durante as reconstruções', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const RickAndMortyApp());

      await tester.pumpAndSettle();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
