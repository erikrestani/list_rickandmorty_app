import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/load_characters_button.dart';

void main() {
  group('LoadCharactersButton', () {
    testWidgets(
      'deve exibir o botão com o texto correto quando não está carregando',
      (WidgetTester tester) async {
        bool buttonPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadCharactersButton(
                isLoading: false,
                onPressed: () => buttonPressed = true,
              ),
            ),
          ),
        );

        expect(find.text('Carregar Personagens'), findsOneWidget);
        expect(find.byIcon(Icons.explore), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(buttonPressed, true);
      },
    );

    testWidgets(
      'deve exibir o indicador de carregamento quando está carregando',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadCharactersButton(isLoading: true, onPressed: () {}),
            ),
          ),
        );

        expect(find.text('Carregar Personagens'), findsNothing);
        expect(find.byIcon(Icons.explore), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('não deve chamar onPressed quando está carregando', (
      WidgetTester tester,
    ) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadCharactersButton(
              isLoading: true,
              onPressed: () => buttonPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(buttonPressed, false);
    });

    testWidgets('deve ter o estilo correto', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadCharactersButton(isLoading: false, onPressed: () {}),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final buttonStyle = button.style;

      expect(buttonStyle, isNotNull);
    });
  });
}
