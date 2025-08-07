import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_details_viewmodel.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_details_header.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_main_section.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_info_card.dart';
import 'package:list_rickandmorty_app/shared/loading_widget.dart';
import 'package:list_rickandmorty_app/shared/error_widget.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int characterId;

  const CharacterDetailsPage({super.key, required this.characterId});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  late final CharacterDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = sl<CharacterDetailsViewModel>();
    _viewModel.loadCharacter(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            switch (_viewModel.state) {
              case CharacterDetailsState.loading:
                return const LoadingWidget();

              case CharacterDetailsState.error:
                return ErrorDisplayWidget(
                  errorMessage: _viewModel.errorMessage,
                  onRetry: () => _viewModel.loadCharacter(widget.characterId),
                );

              case CharacterDetailsState.loaded:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CharacterDetailsHeader(
                        onBackPressed: () => Navigator.of(context).pop(),
                      ),
                      CharacterMainSection(character: _viewModel.character!),
                      CharacterInfoCard(character: _viewModel.character!),
                    ],
                  ),
                );

              case CharacterDetailsState.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
