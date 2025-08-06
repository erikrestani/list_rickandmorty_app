import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fteam/core/di/injection_container.dart' as di;
import 'package:test_fteam/features/characters/presentation/pages/character_list_page.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<CharacterViewModel>(),
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const CharacterListPage(),
      ),
    );
  }
}
