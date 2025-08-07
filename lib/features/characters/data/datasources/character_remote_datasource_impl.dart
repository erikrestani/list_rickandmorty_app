import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/models/character_model.dart';

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});

 @override
Future<List<CharacterModel>> getCharacters(int page) async {
  try {
    final response = await dio.get('character?page=$page');
    debugPrint('🟢 Status code: ${response.statusCode}');
    debugPrint('🟢 Response data: ${response.data}');

    if (response.statusCode == 200) {
      final jsonData = response.data;
      final results = jsonData['results'] as List;
      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar personagens: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('❌ Erro ao buscar personagens: $e');
    throw Exception('Erro ao buscar personagens: $e');
  }
}

}
