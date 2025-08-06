import 'package:flutter/material.dart';
import 'package:test_fteam/features/characters/domain/entities/character.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharacters getCharacters;

  CharacterViewModel(this.getCharacters);

  List<Character> characters = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCharacters() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      characters = await getCharacters();
    } catch (e) {
      errorMessage = 'Erro ao buscar personagens';
    }

    isLoading = false;
    notifyListeners();
  }
}
