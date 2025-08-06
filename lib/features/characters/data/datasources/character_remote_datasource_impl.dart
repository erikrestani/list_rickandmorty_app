import 'package:dio/dio.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/models/character_model.dart';

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get('/character');
      
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final results = jsonData['results'] as List;

        return results.map((e) => CharacterModel.fromJson(e)).toList();
      } else {
        throw Exception('Erro ao buscar personagens: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Timeout de conexão');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Timeout de resposta');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Erro de conexão');
      } else {
        throw Exception('Erro ao buscar personagens: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}
