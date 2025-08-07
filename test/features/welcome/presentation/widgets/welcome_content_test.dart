import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/welcome_content.dart';

void main() {
  group('WelcomeContent', () {
    testWidgets('deve exibir o título e o subtítulo', (
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

    testWidgets('deve ter o alinhamento correto do texto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeContent())),
      );

      final titleFinder = find.text('Bem Vindo!');
      final subtitleFinder = find.text(
        'Explore o universo dos personagens mais loucos da galáxia!',
      );

      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      final subtitleWidget = tester.widget<Text>(subtitleFinder);

      expect(titleWidget.textAlign, TextAlign.center);
      expect(subtitleWidget.textAlign, TextAlign.center);
    });

    testWidgets('deve ter o espaçamento correto entre os elementos', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeContent())),
      );

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 3);
    });
  });
}
