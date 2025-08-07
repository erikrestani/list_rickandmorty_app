import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource_impl.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository_impl.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmodel.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  await _initCharacters();
}

Future<void> _initCore() async {
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.options.baseUrl = 'https://rickandmortyapi.com/api/';
      dio.options.connectTimeout = const Duration(seconds: 60);
      dio.options.receiveTimeout = const Duration(seconds: 60);

      return dio;
    });
  }
}

Future<void> _initCharacters() async {
  if (!sl.isRegistered<CharacterRemoteDatasource>()) {
    sl.registerLazySingleton<CharacterRemoteDatasource>(
      () => CharacterRemoteDatasourceImpl(dio: sl<Dio>()),
    );
  }

  if (!sl.isRegistered<CharacterRepository>()) {
    sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(sl<CharacterRemoteDatasource>()),
    );
  }

  if (!sl.isRegistered<GetCharacters>()) {
    sl.registerLazySingleton<GetCharacters>(
      () => GetCharacters(sl<CharacterRepository>()),
    );
  }

  sl.registerFactory<CharacterViewModel>(
    () => CharacterViewModel(sl<GetCharacters>()),
  );
}
