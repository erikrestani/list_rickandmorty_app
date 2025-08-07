import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharacters getCharacters;

  CharacterViewModel(this.getCharacters);

  final List<Character> characters = [];
  bool isLoading = false;
  String? errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  Future<void> fetchCharacters({bool loadMore = false}) async {
    if (isLoading) return;
    if (loadMore && !_hasMore) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await getCharacters(page: _currentPage);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        if (loadMore) {
          characters.addAll(result);
        } else {
          characters.clear();
          characters.addAll(result);
        }

        _currentPage++;
      }
    } catch (e) {
      final error = e.toString();
      if (error.contains('Timeout')) {
        errorMessage =
            'A conexão demorou muito para responder. Tente novamente.';
      } else if (error.contains('conexão') || error.contains('rede')) {
        errorMessage =
            'Verifique sua conexão com a internet e tente novamente.';
      } else if (error.contains('servidor')) {
        errorMessage =
            'Serviço temporariamente indisponível. Tente novamente em alguns minutos.';
      } else {
        errorMessage =
            'Não foi possível carregar os personagens. Tente novamente.';
      }
    }

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    _currentPage = 1;
    _hasMore = true;
    characters.clear();
    fetchCharacters();
  }
}
