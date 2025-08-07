import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/core/utils/status_color_utils.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/viewmodels/character_details_viewmodel.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_info_card.dart';

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
    _viewModel.onStateChanged = onStateChanged;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.loadCharacter(widget.characterId);
    });
  }

  void onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Personagem'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.textColor,
      ),
      body: Container(
        decoration: AppTheme.backgroundDecoration,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_viewModel.state) {
      case CharacterDetailsState.loading:
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.textColor),
          ),
        );

      case CharacterDetailsState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar personagem',
                style: AppTheme.subtitleStyle.copyWith(
                  color: AppTheme.errorColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _viewModel.errorMessage ?? 'Erro desconhecido',
                style: AppTheme.characterStatusStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _viewModel.loadCharacter(widget.characterId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.textColor,
                ),
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        );

      case CharacterDetailsState.loaded:
        final character = _viewModel.character!;
        return SingleChildScrollView(
          child: Column(
            children: [
              // Container para a imagem no top-center
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.secondaryColor,
                      AppTheme.statusAlive,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagem do personagem
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.shadowColor,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          character.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Informações do personagem
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome
                    Text(
                      character.name,
                      style: AppTheme.titleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Status
                    CharacterInfoCard(
                      title: 'Status',
                      value: character.status,
                      color: StatusColorUtils.getStatusColor(character.status),
                    ),
                    const SizedBox(height: 16),

                    // Espécie
                    CharacterInfoCard(
                      title: 'Espécie',
                      value: character.species,
                      color: AppTheme.statusAlive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case CharacterDetailsState.initial:
        return const SizedBox.shrink();
    }
  }
}
