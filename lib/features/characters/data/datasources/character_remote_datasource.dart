import 'package:list_rickandmorty_app/features/characters/data/models/character_model.dart';

abstract class CharacterRemoteDatasource {
  Future<List<CharacterModel>> getCharacters(int page);
}
