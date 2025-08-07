import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_card.dart';

void main() {
  group('CharacterCard', () {
    late Character testCharacter;

    setUp(() {
      testCharacter = Character(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      );
    });

    testWidgets('deve exibir informações do personagem corretamente', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(character: testCharacter, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Alive'), findsOneWidget);
    });

    testWidgets('deve chamar onTap quando pressionado', (
      WidgetTester tester,
    ) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
              onTap: () => onTapCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CharacterCard));
      await tester.pump();

      expect(onTapCalled, isTrue);
    });

    testWidgets('deve exibir indicador de status com cor correta', (
      WidgetTester tester,
    ) async {
      final aliveCharacter = Character(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        image: 'test.jpg',
      );

      final deadCharacter = Character(
        id: 2,
        name: 'Morty',
        status: 'Dead',
        species: 'Human',
        image: 'test2.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CharacterCard(character: aliveCharacter, onTap: () {}),
                CharacterCard(character: deadCharacter, onTap: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Alive'), findsOneWidget);
      expect(find.text('Dead'), findsOneWidget);
    });

    testWidgets('deve lidar com nomes longos de personagens', (
      WidgetTester tester,
    ) async {
      final longNameCharacter = Character(
        id: 1,
        name: 'Nome Muito Longo de Personagem Que Deve Ser Truncado',
        status: 'Alive',
        species: 'Human',
        image: 'test.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(character: longNameCharacter, onTap: () {}),
          ),
        ),
      );

      expect(
        find.text('Nome Muito Longo de Personagem Que Deve Ser Truncado'),
        findsOneWidget,
      );
    });

    testWidgets('deve exibir placeholder quando imagem falha ao carregar', (
      WidgetTester tester,
    ) async {
      final invalidImageCharacter = Character(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        image: 'url_invalida',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(character: invalidImageCharacter, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Rick'), findsOneWidget);
    });
  });
}
