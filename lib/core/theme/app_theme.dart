import 'package:flutter/material.dart';

/// Classe responsável por gerenciar o tema do app
class AppTheme {
  // Cores principais
  static const Color primaryColor = Color(0xFF2C3E50); // Azul escuro
  static const Color secondaryColor = Color(0xFF27AE60); // Verde
  static const Color backgroundColor = Color(0xFF1A1A1A); // Preto
  static const Color surfaceColor = Color(0xFF2C3E50); // Azul escuro
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFB0B0B0);
  static const Color cardColor = Colors.white;
  static const Color errorColor = Color(0xFFE74C3C);

  // Cores de status dos personagens
  static const Color statusAlive = Color(0xFF27AE60); // Verde
  static const Color statusDead = Color(0xFFE74C3C); // Vermelho
  static const Color statusUnknown = Color(0xFFF39C12); // Laranja

  // Gradientes
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      backgroundColor,
    ],
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF666666),
        ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF666666),
        ),
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
    color: Colors.black87,
  );

  static const TextStyle characterStatusStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF666666),
  );

  // Método para obter cor de status
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return statusAlive;
      case 'dead':
        return statusDead;
      case 'unknown':
        return statusUnknown;
      default:
        return statusUnknown;
    }
  }

  // Decorações de container
  static BoxDecoration get backgroundDecoration => const BoxDecoration(
        gradient: backgroundGradient,
      );

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000), 
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
} 