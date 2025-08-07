import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class StatusColorUtils {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppTheme.statusAlive;
      case 'dead':
        return AppTheme.statusDead;
      case 'unknown':
        return AppTheme.statusUnknown;
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  static String getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return 'Vivo';
      case 'dead':
        return 'Morto';
      case 'unknown':
        return 'Desconhecido';
      default:
        return status;
    }
  }
}
