import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_viewmodel.dart';

class TestGetCharacters implements GetCharacters {
  List<Character>? charactersToReturn;
  Exception? exceptionToThrow;

  @override
  CharacterRepository get repository => throw UnimplementedError();

  @override
  Future<List<Character>> call({int page = 1}) async {
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return charactersToReturn ?? [];
  }
}

void main() {
  group('CharacterViewModel - Gerenciamento de Estado', () {
    late CharacterViewModel viewModel;
    late TestGetCharacters usecase;

    setUp(() {
      usecase = TestGetCharacters();
      viewModel = CharacterViewModel(usecase);
    });

    test(
      'deve carregar personagens com sucesso e atualizar estado corretamente',
      () async {
        final characters = [
          const Character(
            id: 1,
            name: 'Test Character',
            image: 'https://example.com/image.jpg',
            status: 'Alive',
            species: 'Human',
          ),
        ];

        usecase.charactersToReturn = characters;

        await viewModel.fetchCharacters();

        expect(viewModel.characters.length, 1);
        expect(viewModel.characters[0].name, 'Test Character');
        expect(viewModel.characters[0].status, 'Alive');
        expect(viewModel.characters[0].species, 'Human');
        expect(viewModel.isLoading, false);
        expect(viewModel.errorMessage, null);
      },
    );

    test(
      'deve carregar mais personagens e adicionar à lista existente',
      () async {
        final page1 = [
          const Character(
            id: 1,
            name: 'Test Character 1',
            image: 'https://example.com/image1.jpg',
            status: 'Alive',
            species: 'Human',
          ),
        ];

        final page2 = [
          const Character(
            id: 2,
            name: 'Test Character 2',
            image: 'https://example.com/image2.jpg',
            status: 'Dead',
            species: 'Alien',
          ),
        ];

        usecase.charactersToReturn = page1;
        await viewModel.fetchCharacters();

        usecase.charactersToReturn = page2;
        await viewModel.fetchCharacters(loadMore: true);

        expect(viewModel.characters.length, 2);
        expect(viewModel.characters[0].name, 'Test Character 1');
        expect(viewModel.characters[0].status, 'Alive');
        expect(viewModel.characters[1].name, 'Test Character 2');
        expect(viewModel.characters[1].status, 'Dead');
      },
    );

    test(
      'deve definir mensagem de erro específica para timeout de conexão',
      () async {
        usecase.exceptionToThrow = Exception('Timeout de conexão');

        await viewModel.fetchCharacters();

        expect(viewModel.characters.length, 0);
        expect(viewModel.isLoading, false);
        expect(
          viewModel.errorMessage,
          'A conexão demorou muito para responder. Tente novamente.',
        );
      },
    );

    test(
      'deve definir mensagem de erro específica para problemas de conectividade',
      () async {
        usecase.exceptionToThrow = Exception('Erro de conexão');

        await viewModel.fetchCharacters();

        expect(
          viewModel.errorMessage,
          'Verifique sua conexão com a internet e tente novamente.',
        );
      },
    );

    test(
      'deve definir mensagem de erro específica para problemas de servidor',
      () async {
        usecase.exceptionToThrow = Exception('Erro de servidor: 500');

        await viewModel.fetchCharacters();

        expect(
          viewModel.errorMessage,
          'Serviço temporariamente indisponível. Tente novamente em alguns minutos.',
        );
      },
    );

    test(
      'deve definir mensagem de erro genérica para exceções não mapeadas',
      () async {
        usecase.exceptionToThrow = Exception('Erro inesperado');

        await viewModel.fetchCharacters();

        expect(
          viewModel.errorMessage,
          'Não foi possível carregar os personagens. Tente novamente.',
        );
      },
    );

    test('deve resetar estado e recarregar personagens do início', () async {
      final characters = [
        const Character(
          id: 1,
          name: 'Test Character',
          image: 'https://example.com/image.jpg',
          status: 'Alive',
          species: 'Human',
        ),
      ];

      usecase.charactersToReturn = characters;
      await viewModel.fetchCharacters();

      viewModel.reset();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(viewModel.characters.length, 1);
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, null);
    });
  });
}
