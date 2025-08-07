import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColorNeon, width: 1),
      ),
      child: Text(
        'me aprovem por favor!!',
        style: AppTheme.characterStatusStyle.copyWith(
          fontSize: 12,
          color: AppTheme.textSecondaryColor,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
