import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/core/utils/status_color_utils.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterCard({super.key, required this.character, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: AppTheme.cardDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppTheme.borderColorNeon,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonShadowColor,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: CachedNetworkImage(
                        imageUrl: character.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppTheme.surfaceColor,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppTheme.surfaceColor,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    character.name,
                    style: AppTheme.characterNameStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: StatusColorUtils.getStatusColor(
                            character.status,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.statusShadowColor,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        character.status,
                        style: AppTheme.characterStatusStyle.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
