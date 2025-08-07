import 'package:flutter/material.dart';

/// Classe responsável por gerenciar o tema do app
class AppTheme {
  // Cores principais - Design moderno e sutil
  static const Color primaryColor = Color(0xFF1E293B); // Azul escuro sutil
  static const Color secondaryColor = Color(0xFF3B82F6); // Azul neon principal
  static const Color accentColor = Color(0xFF60A5FA); // Azul neon claro
  static const Color backgroundColor = Color(0xFF0F172A); // Fundo escuro
  static const Color surfaceColor = Color(0xFF1E293B); // Superfície escura
  static const Color cardBackgroundColor = Color(0x0A3B82F6); // Azul neon muito sutil
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFF94A3B8);
  static const Color cardColor = Color(0x1A3B82F6); // Azul neon transparente
  static const Color errorColor = Color(0xFFEF4444);

  // Cores de status dos personagens
  static const Color statusAlive = Color(0xFF10B981); // Verde sutil
  static const Color statusDead = Color(0xFFEF4444); // Vermelho
  static const Color statusUnknown = Color(0xFFF59E0B); // Laranja

  // Cores de sombra e borda
  static const Color shadowColor = Color(0x20000000); // Sombra sutil
  static const Color borderColorLight = Color(0x4D3B82F6); // Azul neon mais intenso
  static const Color borderColorNeon = Color(0x803B82F6); // Azul neon mais brilhante
  static const Color borderColorDark = Color(0xFF1E293B);
  static const Color statusShadowColor = Color(0x4D000000); // Sombra para status
  static const Color neonShadowColor = Color(0x403B82F6); // Sombra neon específica
  static const Color neonGlowColor = Color(0x603B82F6); // Brilho neon específico

  // Gradientes sutis
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundColor, surfaceColor],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x1A3B82F6), Color(0x0A3B82F6)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1A3B82F6), Color(0x0A3B82F6)],
  );

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  // Tema escuro (padrão)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  // Estilos de texto reutilizáveis
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static const TextStyle characterNameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle characterStatusStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  // Novos estilos para o design moderno
  static const TextStyle characterNameLargeStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
    shadows: [
      Shadow(
        offset: Offset(0, 2),
        blurRadius: 4,
        color: shadowColor,
      ),
    ],
  );

  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textSecondaryColor,
  );

  static const TextStyle cardValueStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  // Decorações de container
  static BoxDecoration get backgroundDecoration =>
      const BoxDecoration(gradient: backgroundGradient);

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: borderColorNeon, width: 2),
    boxShadow: [
      BoxShadow(
        color: neonShadowColor,
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get neonBorderDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: borderColorNeon, width: 1),
  );

  static BoxDecoration get neonGlowDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: borderColorNeon, width: 2),
    boxShadow: [
      BoxShadow(
        color: neonGlowColor,
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration get headerDecoration => const BoxDecoration(
    gradient: headerGradient,
  );
}
