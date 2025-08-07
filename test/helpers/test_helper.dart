import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_viewmodel.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/viewmodels/welcome_viewmodel.dart';

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
    final mockWelcomeViewModel = WelcomeViewModel(mockGetCharacters);

    if (GetIt.instance.isRegistered<CharacterViewModel>()) {
      GetIt.instance.unregister<CharacterViewModel>();
    }
    if (GetIt.instance.isRegistered<WelcomeViewModel>()) {
      GetIt.instance.unregister<WelcomeViewModel>();
    }
    
    GetIt.instance.registerFactory<CharacterViewModel>(() => mockViewModel);
    GetIt.instance.registerFactory<WelcomeViewModel>(() => mockWelcomeViewModel);
  }

  static void teardownMocks() {
    if (GetIt.instance.isRegistered<CharacterViewModel>()) {
      GetIt.instance.unregister<CharacterViewModel>();
    }
    if (GetIt.instance.isRegistered<WelcomeViewModel>()) {
      GetIt.instance.unregister<WelcomeViewModel>();
    }
  }
}

class MockGetCharacters extends Mock implements GetCharacters {}
