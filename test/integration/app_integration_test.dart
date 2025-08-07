import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/pages/character_list_page.dart';
import '../helpers/test_helper.dart';

void main() {
  group('App - Testes de Integração', () {
    setUp(() {
      TestHelper.setupMockCharacterViewModel();
    });

    tearDown(() {
      TestHelper.teardownMocks();
    });

    testWidgets(
      'deve carregar página de personagens com AppBar e título corretos',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: const CharacterListPage(),
          ),
        );

        await tester.pump(const Duration(milliseconds: 300));
        await tester.pumpAndSettle();

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Rick and Morty'), findsOneWidget);
      },
    );

    testWidgets(
      'deve exibir botão de refresh na AppBar para recarregar dados',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: const CharacterListPage(),
          ),
        );

        await tester.pump(const Duration(milliseconds: 300));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.refresh), findsOneWidget);
      },
    );
  });
}
