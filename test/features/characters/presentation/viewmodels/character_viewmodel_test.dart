import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_viewmodel_test.mocks.dart';

@GenerateMocks([GetCharacters])
void main() {
  late CharacterViewModel viewModel;
  late MockGetCharacters mockGetCharacters;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    viewModel = CharacterViewModel(mockGetCharacters);
  });

  group('CharacterViewModel', () {
    test('deve inicializar com estado vazio', () {
      expect(viewModel.characters, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.activeFilters, isEmpty);
    });

    test('deve carregar personagens com sucesso', () async {
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

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => personagens);

      await viewModel.fetchCharacters();

      expect(viewModel.characters, equals(personagens));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      verify(mockGetCharacters(page: 1)).called(1);
    });

    test('deve lidar com erro ao carregar personagens', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('Erro de rede'));

      await viewModel.fetchCharacters();

      expect(viewModel.characters, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.errorMessage!.contains('Verifique sua conexão'), isTrue);
    });

    test('deve aplicar filtro por nome corretamente', () async {
      final personagens = [
        Character(
          id: 1,
          name: 'Rick',
          status: 'Alive',
          species: 'Human',
          image: 'test.jpg',
        ),
        Character(
          id: 2,
          name: 'Morty',
          status: 'Alive',
          species: 'Human',
          image: 'test2.jpg',
        ),
        Character(
          id: 3,
          name: 'Summer',
          status: 'Alive',
          species: 'Human',
          image: 'test3.jpg',
        ),
      ];

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => personagens);

      await viewModel.fetchCharacters();

      viewModel.sortByName();

      expect(viewModel.activeFilters, contains('name'));
      expect(viewModel.characters.first.name, equals('Morty'));
      expect(viewModel.characters.last.name, equals('Summer'));
    });

    test('deve aplicar filtro por status corretamente', () async {
      final personagens = [
        Character(
          id: 1,
          name: 'Rick',
          status: 'Alive',
          species: 'Human',
          image: 'test.jpg',
        ),
        Character(
          id: 2,
          name: 'Morty',
          status: 'Dead',
          species: 'Human',
          image: 'test2.jpg',
        ),
        Character(
          id: 3,
          name: 'Summer',
          status: 'Alive',
          species: 'Human',
          image: 'test3.jpg',
        ),
      ];

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => personagens);

      await viewModel.fetchCharacters();

      viewModel.sortByStatus();

      expect(viewModel.activeFilters, contains('status'));
      expect(viewModel.characters.first.status, equals('Alive'));
      expect(viewModel.characters.last.status, equals('Dead'));
    });

    test('deve resetar estado corretamente', () async {
      final personagens = [
        Character(
          id: 1,
          name: 'Rick',
          status: 'Alive',
          species: 'Human',
          image: 'test.jpg',
        ),
      ];

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => personagens);

      await viewModel.fetchCharacters();
      viewModel.sortByName();

      viewModel.reset();

      expect(viewModel.characters, isEmpty);
      expect(viewModel.activeFilters, isEmpty);
      expect(viewModel.errorMessage, isNull);
    });

    test('não deve carregar mais quando já está carregando', () async {
      when(mockGetCharacters(page: 1)).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return [];
      });

      final future1 = viewModel.fetchCharacters();
      final future2 = viewModel.fetchCharacters();

      expect(viewModel.isLoading, isTrue);
      await future1;
      await future2;
      verify(mockGetCharacters(page: 1)).called(1);
    });

    test('deve respeitar tempo mínimo de loading', () async {
      final personagens = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: 'Alive',
          species: 'Human',
          image: 'test.jpg',
        ),
      ];

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => personagens);

      final startTime = DateTime.now();
      await viewModel.fetchCharacters();
      final endTime = DateTime.now();

      final duration = endTime.difference(startTime);

      expect(duration.inMilliseconds, greaterThanOrEqualTo(700));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.characters, isNotEmpty);
    });
  });
}
