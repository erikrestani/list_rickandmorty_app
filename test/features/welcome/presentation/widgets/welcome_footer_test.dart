import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/welcome_footer.dart';

void main() {
  group('WelcomeFooter', () {
    testWidgets('deve exibir o texto do footer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeFooter())),
      );

      expect(find.text('me aprovem por favor!!'), findsOneWidget);
    });

    testWidgets('deve ter o alinhamento correto do texto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeFooter())),
      );

      final textWidget = tester.widget<Text>(
        find.text('me aprovem por favor!!'),
      );
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('deve ter o estilo correto', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeFooter())),
      );

      final textWidget = tester.widget<Text>(
        find.text('me aprovem por favor!!'),
      );
      expect(textWidget.style?.fontStyle, FontStyle.italic);
      expect(textWidget.style?.fontSize, 12);
    });

    testWidgets('deve ter o container com o estilo correto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WelcomeFooter())),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.decoration, isNotNull);
    });
  });
}
