import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/viewmodels/welcome_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'welcome_viewmodel_test.mocks.dart';

@GenerateMocks([GetCharacters])
void main() {
  late WelcomeViewModel viewModel;
  late MockGetCharacters mockGetCharacters;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    viewModel = WelcomeViewModel(mockGetCharacters);
  });

  group('WelcomeViewModel', () {
    test('deve inicializar com o estado inicial correto', () {
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, null);
    });

    test(
      'deve definir loading como true quando loadCharactersAndNavigate é chamado',
      () async {
        final characters = [
          const Character(
            id: 1,
            name: 'Rick Sanchez',
            status: 'Alive',
            species: 'Human',
            image: 'https://example.com/rick.jpg',
          ),
        ];

        when(mockGetCharacters(page: 1)).thenAnswer((_) async => characters);

        expect(viewModel.isLoading, false);

        viewModel.loadCharactersAndNavigate(MockBuildContext());

        expect(viewModel.isLoading, true);
      },
    );

    test('deve lidar com o erro quando getCharacters falhar', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('Network error'));

      await viewModel.loadCharactersAndNavigate(MockBuildContext());

      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, isNotNull);
      expect(
        viewModel.errorMessage!.contains('Não foi possível carregar'),
        true,
      );
    });

    test('deve lidar com o erro de timeout', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('Timeout'));

      await viewModel.loadCharactersAndNavigate(MockBuildContext());

      expect(viewModel.errorMessage!.contains('demorou muito'), true);
    });

    test('deve lidar com o erro de rede', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('conexão'));

      await viewModel.loadCharactersAndNavigate(MockBuildContext());

      expect(viewModel.errorMessage!.contains('internet'), true);
    });

    test('deve lidar com o erro do servidor', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('servidor'));

      await viewModel.loadCharactersAndNavigate(MockBuildContext());

      expect(viewModel.errorMessage!.contains('indisponível'), true);
    });

    test('deve limpar o erro quando retry é chamado', () async {
      when(mockGetCharacters(page: 1)).thenThrow(Exception('Network error'));

      await viewModel.loadCharactersAndNavigate(MockBuildContext());
      expect(viewModel.errorMessage, isNotNull);

      when(mockGetCharacters(page: 1)).thenAnswer((_) async => []);
      viewModel.retry(MockBuildContext());

      expect(viewModel.errorMessage, null);
    });

    test('não deve chamar getCharacters se já estiver carregando', () async {
      when(mockGetCharacters(page: 1)).thenAnswer((_) async => []);

      viewModel.loadCharactersAndNavigate(MockBuildContext());
      viewModel.loadCharactersAndNavigate(MockBuildContext());

      verify(mockGetCharacters(page: 1)).called(1);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
