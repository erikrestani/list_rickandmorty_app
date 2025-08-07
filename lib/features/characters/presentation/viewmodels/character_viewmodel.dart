import 'package:flutter/material.dart';
import 'package:test_fteam/features/characters/domain/entities/character.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';

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

    debugPrint('🔄 Buscando página $_currentPage (loadMore: $loadMore)...');

    try {
      final result = await getCharacters(page: _currentPage);

      if (result.isEmpty) {
        _hasMore = false;
        debugPrint('🚫 Nenhum personagem retornado na página $_currentPage');
      } else {
        if (loadMore) {
          characters.addAll(result);
        } else {
          characters.clear();
          characters.addAll(result);
        }

        _currentPage++;
        debugPrint(
          '✅ Página carregada com sucesso. Total de personagens: ${characters.length}',
        );
      }
    } catch (e, stack) {
      errorMessage = 'Erro ao buscar personagens: $e';
      debugPrint('❌ Erro ao buscar personagens: $e\n$stack');
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
