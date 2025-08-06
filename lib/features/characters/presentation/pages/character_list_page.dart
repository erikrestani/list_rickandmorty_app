import 'package:flutter/material.dart';
import 'package:test_fteam/core/di/injection_container.dart';
import 'package:test_fteam/core/theme/app_theme.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmode.dart';
import 'package:test_fteam/features/characters/presentation/widgets/character_card.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late final CharacterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = sl<CharacterViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _viewModel.fetchCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: Container(
        decoration: AppTheme.backgroundDecoration,
        child: Column(
          children: [ 
            Expanded(
              child: ListenableBuilder(
                listenable: _viewModel,
                builder: (context, child) {
                  if (_viewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_viewModel.errorMessage != null) {
                    return Center(
                      child: Text(
                        _viewModel.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final characters = _viewModel.characters;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
