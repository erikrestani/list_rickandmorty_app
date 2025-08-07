import 'package:test_fteam/features/characters/domain/entities/character.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource datasource;

  CharacterRepositoryImpl(this.datasource);

  @override
  Future<List<Character>> getCharacters(int page) async {
    final models = await datasource.getCharacters(page);
    return models.map((model) => model.toEntity()).toList();
  }
}
