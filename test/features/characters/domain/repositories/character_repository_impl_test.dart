import 'package:flutter_test/flutter_test.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/models/character_model.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository_impl.dart';

class TestDatasource implements CharacterRemoteDatasource {
  List<CharacterModel>? charactersToReturn;
  Exception? exceptionToThrow;

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return charactersToReturn ?? [];
  }
}

void main() {
  group('CharacterRepositoryImpl - Conversão de Dados', () {
    late CharacterRepositoryImpl repository;
    late TestDatasource datasource;

    setUp(() {
      datasource = TestDatasource();
      repository = CharacterRepositoryImpl(datasource);
    });

    test(
      'deve converter CharacterModel para Character entities com dados preservados',
      () async {
        final models = [
          CharacterModel(
            id: 1,
            name: 'Test Character 1',
            image: 'https://example.com/image1.jpg',
            status: 'Alive',
            species: 'Human',
          ),
          CharacterModel(
            id: 2,
            name: 'Test Character 2',
            image: 'https://example.com/image2.jpg',
            status: 'Dead',
            species: 'Alien',
          ),
        ];

        datasource.charactersToReturn = models;

        final result = await repository.getCharacters(1);

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
      'deve retornar lista vazia quando datasource não retorna personagens',
      () async {
        datasource.charactersToReturn = [];

        final result = await repository.getCharacters(1);

        expect(result.length, 0);
      },
    );

    test('deve propagar exceção do datasource para camada superior', () async {
      datasource.exceptionToThrow = Exception('Erro de rede');

      expect(() => repository.getCharacters(1), throwsA(isA<Exception>()));
    });
  });
}
