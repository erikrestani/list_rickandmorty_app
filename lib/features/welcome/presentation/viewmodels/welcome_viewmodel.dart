import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/pages/character_list_page.dart';

class WelcomeViewModel extends ChangeNotifier {
  final GetCharacters getCharacters;

  WelcomeViewModel(this.getCharacters);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCharactersAndNavigate(BuildContext context) async {
    if (_isLoading) return;

    _setLoading(true);
    _clearError();

    try {
      final characters = await getCharacters(page: 1);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CharacterListPage(initialCharacters: characters),
          ),
        );
      }
    } catch (e) {
      _setError(_handleError(e.toString()));
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String _handleError(String error) {
    if (error.contains('Timeout')) {
      return 'A conexão demorou muito para responder. Tente novamente.';
    } else if (error.contains('conexão') || error.contains('rede')) {
      return 'Verifique sua conexão com a internet e tente novamente.';
    } else if (error.contains('servidor')) {
      return 'Serviço temporariamente indisponível. Tente novamente em alguns minutos.';
    } else {
      return 'Não foi possível carregar os personagens. Tente novamente.';
    }
  }

  void retry(BuildContext context) {
    loadCharactersAndNavigate(context);
  }
}
