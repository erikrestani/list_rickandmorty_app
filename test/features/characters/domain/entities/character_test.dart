import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';

void main() {
  group('Character - Entidade de Domínio', () {
    test(
      'deve criar personagem com todos os campos obrigatórios preenchidos corretamente',
      () {
        const character = Character(
          id: 1,
          name: 'Test Character',
          image: 'https://example.com/image.jpg',
          status: 'Alive',
          species: 'Human',
        );

        expect(character.id, 1);
        expect(character.name, 'Test Character');
        expect(character.image, 'https://example.com/image.jpg');
        expect(character.status, 'Alive');
        expect(character.species, 'Human');
      },
    );

    test(
      'deve comparar personagens com mesmo ID e dados como sendo iguais',
      () {
        const character1 = Character(
          id: 1,
          name: 'Test Character',
          image: 'https://example.com/image.jpg',
          status: 'Alive',
          species: 'Human',
        );

        const character2 = Character(
          id: 1,
          name: 'Test Character',
          image: 'https://example.com/image.jpg',
          status: 'Alive',
          species: 'Human',
        );

        expect(character1, equals(character2));
      },
    );
  });
}
