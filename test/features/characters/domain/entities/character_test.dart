import 'package:flutter_test/flutter_test.dart';
import 'package:test_fteam/features/characters/domain/entities/character.dart';

void main() {
  group('Entidade Character', () {
    const tCharacter = Character(
      id: 1,
      name: 'Rick Sanchez',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      status: 'Alive',
      species: 'Human',
    );

    test('deve criar uma instância de Character com valores corretos', () {
      expect(tCharacter.id, 1);
      expect(tCharacter.name, 'Rick Sanchez');
      expect(
        tCharacter.image,
        'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      );
      expect(tCharacter.status, 'Alive');
      expect(tCharacter.species, 'Human');
    });

    test('deve ser igual quando todas as propriedades são as mesmas', () {
      const character1 = Character(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      const character2 = Character(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      expect(character1, equals(character2));
    });

    test('deve ser diferente quando as propriedades são diferentes', () {
      const character1 = Character(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      const character2 = Character(
        id: 2,
        name: 'Morty Smith',
        image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      expect(character1, isNot(equals(character2)));
    });

    test('deve ter o hashCode correto', () {
      const character1 = Character(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      const character2 = Character(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        status: 'Alive',
        species: 'Human',
      );

      expect(character1.hashCode, equals(character2.hashCode));
    });

    test('deve ter uma representação de toString significativa', () {
      expect(tCharacter.toString(), contains('Character'));
    });
  });
}
