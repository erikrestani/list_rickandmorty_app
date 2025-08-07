import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_card.dart';

void main() {
  group('CharacterCard - Widget de Exibição', () {
    const character = Character(
      id: 1,
      name: 'Test Character',
      image: 'https://example.com/image.jpg',
      status: 'Alive',
      species: 'Human',
    );

    testWidgets(
      'deve exibir nome do personagem e status com espécie no formato correto',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: CharacterCard(character: character)),
          ),
        );

        expect(find.text('Test Character'), findsOneWidget);
        expect(find.text('Alive - Human'), findsOneWidget);
      },
    );

    testWidgets(
      'deve executar callback onTap quando o card for pressionado pelo usuário',
      (WidgetTester tester) async {
        bool onTapCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CharacterCard(
                character: character,
                onTap: () => onTapCalled = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(InkWell));
        await tester.pump();

        expect(onTapCalled, true);
      },
    );
  });
}
