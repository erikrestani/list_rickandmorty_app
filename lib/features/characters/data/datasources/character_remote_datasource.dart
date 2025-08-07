import 'package:test_fteam/features/characters/data/models/character_model.dart';

abstract class CharacterRemoteDatasource {
  Future<List<CharacterModel>> getCharacters(int page);
}
