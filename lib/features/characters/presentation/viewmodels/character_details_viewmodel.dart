import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_character_by_id.dart';

enum CharacterDetailsState { initial, loading, loaded, error }

class CharacterDetailsViewModel {
  final GetCharacterById getCharacterById;
  VoidCallback? onStateChanged;

  CharacterDetailsViewModel(this.getCharacterById);

  CharacterDetailsState _state = CharacterDetailsState.initial;
  Character? _character;
  String? _errorMessage;

  CharacterDetailsState get state => _state;
  Character? get character => _character;
  String? get errorMessage => _errorMessage;

  Future<void> loadCharacter(int id) async {
    _state = CharacterDetailsState.loading;
    _errorMessage = null;
    onStateChanged?.call();

    try {
      _character = await getCharacterById(id);
      _state = CharacterDetailsState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = CharacterDetailsState.error;
    }

    onStateChanged?.call();
  }
}
