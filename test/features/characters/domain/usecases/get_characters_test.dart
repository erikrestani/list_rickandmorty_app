import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_characters_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late GetCharacters usecase;
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
    usecase = GetCharacters(mockRepository);
  });

  group('GetCharacters', () {
    test('deve obter personagens do repository', () async {
      final personagens = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: 'Alive',
          species: 'Human',
          image: 'test.jpg',
        ),
        Character(
          id: 2,
          name: 'Morty Smith',
          status: 'Alive',
          species: 'Human',
          image: 'test2.jpg',
        ),
      ];

      when(
        mockRepository.getCharacters(1),
      ).thenAnswer((_) async => personagens);

      final result = await usecase(page: 1);

      expect(result, equals(personagens));
      verify(mockRepository.getCharacters(1)).called(1);
    });

    test('deve obter personagens da página 2', () async {
      final personagens = [
        Character(
          id: 21,
          name: 'Aqua Morty',
          status: 'Dead',
          species: 'Humanoid',
          image: 'test3.jpg',
        ),
      ];

      when(
        mockRepository.getCharacters(2),
      ).thenAnswer((_) async => personagens);

      final result = await usecase(page: 2);

      expect(result, equals(personagens));
      verify(mockRepository.getCharacters(2)).called(1);
    });

    test('deve retornar lista vazia quando repository retorna vazio', () async {
      when(mockRepository.getCharacters(1)).thenAnswer((_) async => []);

      final result = await usecase(page: 1);

      expect(result, isEmpty);
      verify(mockRepository.getCharacters(1)).called(1);
    });

    test('deve propagar erros do repository', () async {
      when(
        mockRepository.getCharacters(1),
      ).thenThrow(Exception('Erro do repository'));

      expect(() => usecase(page: 1), throwsException);
      verify(mockRepository.getCharacters(1)).called(1);
    });
  });
}
