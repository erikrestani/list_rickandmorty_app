import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters(int page);
}
