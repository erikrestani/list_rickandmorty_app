import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/shared/scroll_to_top_button.dart';

void main() {
  group('ScrollToTopButton', () {
    late ScrollController scrollController;

    setUp(() {
      scrollController = ScrollController();
    });

    tearDown(() {
      scrollController.dispose();
    });

    testWidgets('deve renderizar corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Container(height: 1000),
                ),
                ScrollToTopButton(scrollController: scrollController),
              ],
            ),
          ),
        ),
      );

      // Deve renderizar o FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
    });

    testWidgets('deve chamar scrollToTop quando pressionado', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Container(height: 1000),
                ),
                ScrollToTopButton(scrollController: scrollController),
              ],
            ),
          ),
        ),
      );

      scrollController.jumpTo(300);
      await tester.pump();

      await tester.tap(find.byType(FloatingActionButton), warnIfMissed: false);
      
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('deve respeitar configurações customizadas', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Container(height: 1000),
                ),
                ScrollToTopButton(
                  scrollController: scrollController,
                  showThreshold: 100.0,
                  icon: Icons.arrow_upward,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    });

    testWidgets('deve renderizar sem erros', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Container(height: 1000),
                ),
                ScrollToTopButton(scrollController: scrollController),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
  
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsNothing);
    });
  });
}
