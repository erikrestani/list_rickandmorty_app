import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource_impl.dart';
import 'package:test_fteam/features/characters/data/models/character_model.dart';

import 'character_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('CharacterRemoteDatasourceImpl - Requisições HTTP', () {
    late CharacterRemoteDatasourceImpl datasource;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      datasource = CharacterRemoteDatasourceImpl(dio: mockDio);
    });

    group('getCharacters - Cenários de Sucesso', () {
      test(
        'deve retornar lista de personagens quando API retorna dados válidos',
        () async {
          final charactersJson = [
            {
              'id': 1,
              'name': 'Rick Sanchez',
              'image': 'https://example.com/rick.jpg',
              'status': 'Alive',
              'species': 'Human',
            },
            {
              'id': 2,
              'name': 'Morty Smith',
              'image': 'https://example.com/morty.jpg',
              'status': 'Alive',
              'species': 'Human',
            },
            {
              'id': 3,
              'name': 'Summer Smith',
              'image': 'https://example.com/summer.jpg',
              'status': 'Alive',
              'species': 'Human',
            },
          ];
          final responseData = {'results': charactersJson};

          when(mockDio.get('character?page=1')).thenAnswer(
            (_) async => Response(
              data: responseData,
              statusCode: 200,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          final result = await datasource.getCharacters(1);

          expect(result, isA<List<CharacterModel>>());
          expect(result.length, 3);
          expect(result[0].id, 1);
          expect(result[0].name, 'Rick Sanchez');
          expect(result[1].id, 2);
          expect(result[1].name, 'Morty Smith');
          expect(result[2].id, 3);
          expect(result[2].name, 'Summer Smith');

          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test(
        'deve retornar lista vazia quando API não retorna personagens',
        () async {
          final responseData = {'results': []};

          when(mockDio.get('character?page=1')).thenAnswer(
            (_) async => Response(
              data: responseData,
              statusCode: 200,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          final result = await datasource.getCharacters(1);

          expect(result, isEmpty);
          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test('deve fazer requisição com número de página correto', () async {
        final charactersJson = [
          {
            'id': 1,
            'name': 'Test Character',
            'image': 'https://example.com/image.jpg',
            'status': 'Alive',
            'species': 'Human',
          },
        ];
        final responseData = {'results': charactersJson};

        when(mockDio.get('character?page=5')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: 'character?page=5'),
          ),
        );

        await datasource.getCharacters(5);

        verify(mockDio.get('character?page=5')).called(1);
      });
    });

    group('getCharacters - Cenários de Erro HTTP', () {
      test(
        'deve lançar exceção quando API retorna status code diferente de 200',
        () async {
          when(mockDio.get('character?page=1')).thenAnswer(
            (_) async => Response(
              data: {'error': 'Not found'},
              statusCode: 404,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );
          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );
    });

    group('getCharacters - Cenários de Erro de Rede', () {
      test(
        'deve lançar exceção de timeout quando há timeout de conexão',
        () async {
          when(mockDio.get('character?page=1')).thenThrow(
            DioException(
              type: DioExceptionType.connectionTimeout,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test(
        'deve lançar exceção de timeout quando há timeout de recebimento',
        () async {
          when(mockDio.get('character?page=1')).thenThrow(
            DioException(
              type: DioExceptionType.receiveTimeout,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test(
        'deve lançar exceção de erro de conexão quando não há conectividade',
        () async {
          when(mockDio.get('character?page=1')).thenThrow(
            DioException(
              type: DioExceptionType.connectionError,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test(
        'deve lançar exceção de erro de rede para outros tipos de DioException',
        () async {
          when(mockDio.get('character?page=1')).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(path: 'character?page=1'),
            ),
          );

          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );

      test(
        'deve lançar exceção inesperada para outras exceções não tratadas',
        () async {
          when(
            mockDio.get('character?page=1'),
          ).thenThrow(Exception('Erro inesperado'));

          expect(() => datasource.getCharacters(1), throwsA(isA<Exception>()));

          verify(mockDio.get('character?page=1')).called(1);
        },
      );
    });
  });
}
