import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource_impl.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository_impl.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';
import 'package:test_fteam/features/characters/presentation/pages/character_list_page.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmode.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CharacterRemoteDatasourceImpl(http.Client())),
        ProxyProvider<CharacterRemoteDatasourceImpl, CharacterRepositoryImpl>(
          update: (_, datasource, __) => CharacterRepositoryImpl(datasource),
        ),
        ProxyProvider<CharacterRepositoryImpl, GetCharacters>(
          update: (_, repo, __) => GetCharacters(repo),
        ),
        ChangeNotifierProvider<CharacterViewModel>(
          create: (context) =>
              CharacterViewModel(context.read<GetCharacters>()),
        ),
      ],
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
