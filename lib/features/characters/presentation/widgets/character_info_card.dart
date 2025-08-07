import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/core/utils/status_color_utils.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';

class CharacterInfoCard extends StatelessWidget {
  final Character character;

  const CharacterInfoCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Status', style: AppTheme.cardTitleStyle),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: StatusColorUtils.getStatusColor(character.status),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.statusShadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(character.status, style: AppTheme.cardValueStyle),
              ],
            ),
            const SizedBox(height: 24), 
            Row(
              children: [
                Icon(
                  Icons.category,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Espécie', style: AppTheme.cardTitleStyle),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.statusAlive,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.statusShadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(character.species, style: AppTheme.cardValueStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
