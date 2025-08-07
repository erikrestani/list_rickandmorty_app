import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/data/models/character_model.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';

void main() {
  group('CharacterModel - Conversão de Dados', () {
    test('deve criar CharacterModel a partir de JSON com todos os campos', () {
      const json = {
        'id': 1,
        'name': 'Test Character',
        'image': 'https://example.com/image.jpg',
        'status': 'Alive',
        'species': 'Human',
      };

      final model = CharacterModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'Test Character');
      expect(model.image, 'https://example.com/image.jpg');
      expect(model.status, 'Alive');
      expect(model.species, 'Human');
    });

    test(
      'deve converter CharacterModel para entidade Character com dados corretos',
      () {
        const model = CharacterModel(
          id: 1,
          name: 'Test Character',
          image: 'https://example.com/image.jpg',
          status: 'Alive',
          species: 'Human',
        );

        final entity = model.toEntity();

        expect(entity, isA<Character>());
        expect(entity.id, 1);
        expect(entity.name, 'Test Character');
        expect(entity.image, 'https://example.com/image.jpg');
        expect(entity.status, 'Alive');
        expect(entity.species, 'Human');
      },
    );

    test('deve converter CharacterModel para JSON com estrutura correta', () {
      const model = CharacterModel(
        id: 1,
        name: 'Test Character',
        image: 'https://example.com/image.jpg',
        status: 'Alive',
        species: 'Human',
      );

      final json = model.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Test Character');
      expect(json['image'], 'https://example.com/image.jpg');
      expect(json['status'], 'Alive');
      expect(json['species'], 'Human');
    });

    test(
      'deve criar CharacterModel com construtor e validar todos os campos',
      () {
        const model = CharacterModel(
          id: 2,
          name: 'Rick Sanchez',
          image: 'https://example.com/rick.jpg',
          status: 'Alive',
          species: 'Human',
        );

        expect(model.id, 2);
        expect(model.name, 'Rick Sanchez');
        expect(model.image, 'https://example.com/rick.jpg');
        expect(model.status, 'Alive');
        expect(model.species, 'Human');
      },
    );
  });
}
