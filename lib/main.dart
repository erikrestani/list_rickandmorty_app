import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart' as di;
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ListRickAndMortyApp());
}

class ListRickAndMortyApp extends StatelessWidget {
  const ListRickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const WelcomePage(),
    );
  }
}
