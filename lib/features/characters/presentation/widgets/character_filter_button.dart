import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class CharacterFilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CharacterFilterButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.neonBorderDecoration,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.textColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_list),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
