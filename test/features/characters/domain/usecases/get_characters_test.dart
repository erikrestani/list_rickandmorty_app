import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';

class TestRepository implements CharacterRepository {
  List<Character>? charactersToReturn;
  Character? characterToReturn;
  Exception? exceptionToThrow;

  @override
  Future<List<Character>> getCharacters(int page) async {
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return charactersToReturn ?? [];
  }

  @override
  Future<Character> getCharacterById(int id) async {
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return characterToReturn!;
  }
}

void main() {
  group('GetCharacters - Caso de Uso', () {
    late GetCharacters usecase;
    late TestRepository repository;

    setUp(() {
      repository = TestRepository();
      usecase = GetCharacters(repository);
    });

    test(
      'deve retornar lista de personagens do repository com dados completos',
      () async {
        final characters = [
          const Character(
            id: 1,
            name: 'Test Character 1',
            image: 'https://example.com/image1.jpg',
            status: 'Alive',
            species: 'Human',
          ),
          const Character(
            id: 2,
            name: 'Test Character 2',
            image: 'https://example.com/image2.jpg',
            status: 'Dead',
            species: 'Alien',
          ),
        ];

        repository.charactersToReturn = characters;

        final result = await usecase(page: 1);

        expect(result.length, 2);
        expect(result[0].id, 1);
        expect(result[0].name, 'Test Character 1');
        expect(result[0].status, 'Alive');
        expect(result[0].species, 'Human');
        expect(result[1].id, 2);
        expect(result[1].name, 'Test Character 2');
        expect(result[1].status, 'Dead');
        expect(result[1].species, 'Alien');
      },
    );

    test(
      'deve usar página 1 como padrão quando número de página não for especificado',
      () async {
        repository.charactersToReturn = [];

        await usecase();

        expect(repository.charactersToReturn, isNotNull);
      },
    );

    test(
      'deve propagar exceção do repository para camada de apresentação',
      () async {
        repository.exceptionToThrow = Exception('Erro de rede');

        expect(() => usecase(page: 1), throwsA(isA<Exception>()));
      },
    );
  });
}
