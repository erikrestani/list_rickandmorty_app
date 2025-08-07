import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bem Vindo!',
          style: AppTheme.characterNameLargeStyle.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Explore o universo dos personagens mais loucos da galáxia!',
          style: AppTheme.characterStatusStyle.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
