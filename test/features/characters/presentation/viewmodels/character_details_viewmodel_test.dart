import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_character_by_id.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_details_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_details_viewmodel_test.mocks.dart';

@GenerateMocks([GetCharacterById])
void main() {
  late CharacterDetailsViewModel viewModel;
  late MockGetCharacterById mockGetCharacterById;

  setUp(() {
    mockGetCharacterById = MockGetCharacterById();
    viewModel = CharacterDetailsViewModel(mockGetCharacterById);
  });

  group('CharacterDetailsViewModel', () {
    test('estado inicial deve ser initial', () {
      expect(viewModel.state, equals(CharacterDetailsState.initial));
      expect(viewModel.character, isNull);
      expect(viewModel.errorMessage, equals(''));
    });

    test('loadCharacter deve atualizar estado para loading depois loaded', () async {
      final personagem = Character(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        image: 'test.jpg',
      );

      when(mockGetCharacterById(1))
          .thenAnswer((_) async => personagem);

      final future = viewModel.loadCharacter(1);

      expect(viewModel.state, equals(CharacterDetailsState.loading));
      expect(viewModel.errorMessage, equals(''));

      await future;

      expect(viewModel.state, equals(CharacterDetailsState.loaded));
      expect(viewModel.character, equals(personagem));
      expect(viewModel.errorMessage, equals(''));
      verify(mockGetCharacterById(1)).called(1);
    });

    test('loadCharacter deve lidar com erros', () async {
      when(mockGetCharacterById(1))
          .thenThrow(Exception('Personagem não encontrado'));

      await viewModel.loadCharacter(1);

      expect(viewModel.state, equals(CharacterDetailsState.error));
      expect(viewModel.character, isNull);
      expect(viewModel.errorMessage, contains('Personagem não encontrado'));
    });
  });
}
