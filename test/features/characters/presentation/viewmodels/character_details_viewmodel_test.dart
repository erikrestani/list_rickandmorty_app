import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_character_by_id.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_details_viewmodel.dart';

class MockGetCharacterById implements GetCharacterById {
  Character? characterToReturn;
  Exception? exceptionToThrow;

  @override
  CharacterRepository get repository => throw UnimplementedError();

  @override
  Future<Character> call(int id) async {
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return characterToReturn!;
  }
}

void main() {
  late CharacterDetailsViewModel viewModel;
  late MockGetCharacterById mockGetCharacterById;

  setUp(() {
    mockGetCharacterById = MockGetCharacterById();
    viewModel = CharacterDetailsViewModel(mockGetCharacterById);
  });

  const testCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    status: 'Alive',
    species: 'Human',
  );

  test('initial state should be initial', () {
    expect(viewModel.state, CharacterDetailsState.initial);
    expect(viewModel.character, null);
    expect(viewModel.errorMessage, null);
  });

  test('loadCharacter should update state to loading then loaded', () async {
    mockGetCharacterById.characterToReturn = testCharacter;

    final future = viewModel.loadCharacter(1);

    expect(viewModel.state, CharacterDetailsState.loading);
    expect(viewModel.character, null);
    expect(viewModel.errorMessage, null);

    await future;

    expect(viewModel.state, CharacterDetailsState.loaded);
    expect(viewModel.character, testCharacter);
    expect(viewModel.errorMessage, null);
  });

  test(
    'loadCharacter should update state to error when exception occurs',
    () async {
      mockGetCharacterById.exceptionToThrow = Exception('Test error');

      await viewModel.loadCharacter(1);

      expect(viewModel.state, CharacterDetailsState.error);
      expect(viewModel.character, null);
      expect(viewModel.errorMessage, 'Exception: Test error');
    },
  );
}
