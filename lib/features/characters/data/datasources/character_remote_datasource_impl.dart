import 'package:dio/dio.dart';
import 'package:list_rickandmorty_app/features/characters/data/models/character_model.dart';
import 'package:list_rickandmorty_app/features/characters/data/datasources/character_remote_datasource.dart';

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      final response = await dio.get('character?page=$page');

      if (response.statusCode == 200) {
        final jsonData = response.data;
        final results = jsonData['results'] as List;
        return results.map((e) => CharacterModel.fromJson(e)).toList();
      } else {
        throw Exception('Erro de servidor: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Timeout de conexão');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Erro de conexão');
      } else {
        throw Exception('Erro de rede');
      }
    } catch (e) {
      throw Exception('Erro inesperado');
    }
  }
}
