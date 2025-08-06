import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/models/character_model.dart';

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final http.Client client;

  CharacterRemoteDatasourceImpl(this.client);

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List;

      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar personagens');
    }
  }
}
