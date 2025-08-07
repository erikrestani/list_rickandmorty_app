import 'package:flutter/material.dart';
import 'package:test_fteam/core/di/injection_container.dart';
import 'package:test_fteam/core/theme/app_theme.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmodel.dart';
import 'package:test_fteam/features/characters/presentation/widgets/character_card.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late final CharacterViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = sl<CharacterViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        _viewModel.fetchCharacters();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_viewModel.isLoading) {
        _viewModel.fetchCharacters(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.textColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _viewModel.reset(),
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.backgroundDecoration,
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            if (_viewModel.isLoading && _viewModel.characters.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.textColor),
                ),
              );
            }

            if (_viewModel.errorMessage != null &&
                _viewModel.characters.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _viewModel.errorMessage!,
                      style: AppTheme.subtitleStyle.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _viewModel.fetchCharacters(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.textColor,
                      ),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => _viewModel.reset(),
              color: AppTheme.primaryColor,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _viewModel.characters.length + 1,
                itemBuilder: (context, index) {
                  if (index == _viewModel.characters.length) {
                    return _viewModel.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
                  }

                  final character = _viewModel.characters[index];
                  return CharacterCard(
                    character: character,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Clicou em ${character.name}'),
                          backgroundColor: AppTheme.secondaryColor,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
