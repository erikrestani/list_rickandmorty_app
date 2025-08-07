import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_viewmodel.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_list_header.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_list_content.dart';
import 'package:list_rickandmorty_app/shared/loading_widget.dart';
import 'package:list_rickandmorty_app/shared/error_widget.dart';

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
    _viewModel.initialize();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          CharacterListHeader(
            onFilterPressed: () => _viewModel.showFilterDialog(context),
            onRefreshPressed: _viewModel.reset,
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, child) {
                if (_viewModel.isLoading && _viewModel.characters.isEmpty) {
                  return const LoadingWidget();
                }

                if (_viewModel.errorMessage != null &&
                    _viewModel.characters.isEmpty) {
                  return ErrorDisplayWidget(
                    errorMessage: _viewModel.errorMessage!,
                    onRetry: _viewModel.retry,
                  );
                }

                return CharacterListContent(
                  characters: _viewModel.characters,
                  isLoading: _viewModel.isLoading,
                  scrollController: _viewModel.scrollController,
                  onCharacterTap: (character) =>
                      _viewModel.navigateToCharacterDetails(context, character),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
