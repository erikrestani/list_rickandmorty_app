import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/domain/usecases/get_characters.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_filter_dialog.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/pages/character_details_page.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharacters getCharacters;

  CharacterViewModel(this.getCharacters);

  final List<Character> characters = [];
  final List<Character> _allCharacters = [];
  final ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isRefreshing = false;
  String? errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;
  List<String> _activeFilters = [];

  List<String> get activeFilters => _activeFilters;

  void initialize() {
    scrollController.addListener(_onScroll);
    fetchCharacters();
  }

  void initializeWithCharacters(List<Character>? initialCharacters) {
    scrollController.addListener(_onScroll);

    if (initialCharacters != null && initialCharacters.isNotEmpty) {
      _allCharacters.addAll(initialCharacters);
      characters.addAll(initialCharacters);
      _currentPage = 2;
      notifyListeners();
    } else {
      fetchCharacters();
    }
  }

  Future<void> loadCharacters() async {
    if (characters.isEmpty && !isLoading) {
      await fetchCharacters();
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        _hasMore) {
      fetchCharacters(loadMore: true);
    }
  }

  Future<void> fetchCharacters({bool loadMore = false}) async {
    if (isLoading) return;
    if (loadMore && !_hasMore) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final startTime = DateTime.now();
    const minimumLoadingTime = Duration(milliseconds: 800);

    try {
      final result = await getCharacters(page: _currentPage);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        if (loadMore) {
          _allCharacters.addAll(result);
        } else {
          _allCharacters.clear();
          _allCharacters.addAll(result);
        }

        _applyFilters();
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

    final elapsedTime = DateTime.now().difference(startTime);
    if (elapsedTime < minimumLoadingTime) {
      await Future.delayed(minimumLoadingTime - elapsedTime);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (isRefreshing) return;

    isRefreshing = true;
    errorMessage = null;
    notifyListeners();

    final startTime = DateTime.now();
    const minimumLoadingTime = Duration(milliseconds: 800);

    try {
      _currentPage = 1;
      _hasMore = true;
      _allCharacters.clear();
      characters.clear();
      _activeFilters.clear();

      final result = await getCharacters(page: _currentPage);

      if (result.isNotEmpty) {
        _allCharacters.addAll(result);
        _applyFilters();
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

    final elapsedTime = DateTime.now().difference(startTime);
    if (elapsedTime < minimumLoadingTime) {
      await Future.delayed(minimumLoadingTime - elapsedTime);
    }

    isRefreshing = false;
    notifyListeners();
  }

  void reset() {
    refresh();
  }

  void applyFilters(List<String> filters) {
    _activeFilters = filters;
    _applyFilters();
    notifyListeners();
  }

  void retry() {
    fetchCharacters();
  }

  void _applyFilters() {
    if (_activeFilters.isEmpty) {
      characters.clear();
      characters.addAll(_allCharacters);
      return;
    }

    List<Character> filteredCharacters = List.from(_allCharacters);

    for (final filter in _activeFilters) {
      switch (filter) {
        case 'name':
          filteredCharacters.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'status':
          filteredCharacters.sort((a, b) => a.status.compareTo(b.status));
          break;
      }
    }

    characters.clear();
    characters.addAll(filteredCharacters);
  }

  void sortByName() {
    _activeFilters = ['name'];
    _applyFilters();
    notifyListeners();
  }

  void sortByStatus() {
    _activeFilters = ['status'];
    _applyFilters();
    notifyListeners();
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CharacterFilterDialog(
        onApplyFilters: applyFilters,
        currentFilters: activeFilters,
      ),
    );
  }

  void navigateToCharacterDetails(BuildContext context, Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailsPage(characterId: character.id),
      ),
    );
  }
}
