import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/repositories/character_repository.dart';

class GetCharacterById {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  Future<Character> call(int id) async {
    return await repository.getCharacterById(id);
  }
}
