import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_filter_button.dart';

class CharacterListHeader extends StatelessWidget {
  final VoidCallback onFilterPressed;
  final VoidCallback onRefreshPressed;

  const CharacterListHeader({
    super.key,
    required this.onFilterPressed,
    required this.onRefreshPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Rick and Morty',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            CharacterFilterButton(onPressed: onFilterPressed, label: 'Filtrar'),
            const SizedBox(width: 12),
            Container(
              decoration: AppTheme.neonBorderDecoration,
              child: IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: AppTheme.textColor,
                  size: 20,
                ),
                onPressed: onRefreshPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
