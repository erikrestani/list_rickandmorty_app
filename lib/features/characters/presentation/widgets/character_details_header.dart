import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class CharacterDetailsHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const CharacterDetailsHeader({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppTheme.textColor,
                size: 20,
              ),
              onPressed: onBackPressed,
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Text(
              'Detalhes do Personagem',
              style: AppTheme.titleStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 56),
        ],
      ),
    );
  }
}
