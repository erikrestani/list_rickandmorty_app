import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:test_fteam/features/characters/domain/entities/character.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmodel.dart';

class TestHelper {
  static Character createCharacter({
    int? id,
    String? name,
    String? image,
    String? status,
    String? species,
  }) {
    return Character(
      id: id ?? 1,
      name: name ?? 'Test Character',
      image: image ?? 'https://example.com/image.jpg',
      status: status ?? 'Alive',
      species: species ?? 'Human',
    );
  }

  static Map<String, dynamic> createCharacterJson({
    int? id,
    String? name,
    String? image,
    String? status,
    String? species,
  }) {
    return {
      'id': id ?? 1,
      'name': name ?? 'Test Character',
      'image': image ?? 'https://example.com/image.jpg',
      'status': status ?? 'Alive',
      'species': species ?? 'Human',
    };
  }

  static List<Character> createCharacters(int count) {
    return List.generate(count, (index) => createCharacter(id: index + 1));
  }

  static List<Map<String, dynamic>> createCharactersJson(int count) {
    return List.generate(count, (index) => createCharacterJson(id: index + 1));
  }

  static void setupMockCharacterViewModel() {
    final mockGetCharacters = MockGetCharacters();
    final mockViewModel = CharacterViewModel(mockGetCharacters);

    // Registrar o mock no GetIt
    if (GetIt.instance.isRegistered<CharacterViewModel>()) {
      GetIt.instance.unregister<CharacterViewModel>();
    }
    GetIt.instance.registerFactory<CharacterViewModel>(() => mockViewModel);
  }

  static void teardownMocks() {
    if (GetIt.instance.isRegistered<CharacterViewModel>()) {
      GetIt.instance.unregister<CharacterViewModel>();
    }
  }
}

class MockGetCharacters extends Mock implements GetCharacters {}
