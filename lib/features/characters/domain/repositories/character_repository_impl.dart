import 'package:list_rickandmorty_app/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource datasource;

  CharacterRepositoryImpl(this.datasource);

  @override
  Future<List<Character>> getCharacters(int page) async {
    final models = await datasource.getCharacters(page);
    return models.map((model) => model.toEntity()).toList();
  }
}
