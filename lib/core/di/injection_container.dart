import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:test_fteam/features/characters/data/datasources/character_remote_datasource_impl.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository.dart';
import 'package:test_fteam/features/characters/domain/repositories/character_repository_impl.dart';
import 'package:test_fteam/features/characters/domain/usecases/get_characters.dart';
import 'package:test_fteam/features/characters/presentation/viewmodels/character_viewmode.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initCore();

  await _initCharacters();
}

Future<void> _initCore() async {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://rickandmortyapi.com/api/';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ),
    );

    return dio;
  });
}

Future<void> _initCharacters() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<CharacterRemoteDatasource>(
    () => CharacterRemoteDatasourceImpl(sl<http.Client>()),
  );

  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl<CharacterRemoteDatasource>()),
  );

  sl.registerLazySingleton<GetCharacters>(
    () => GetCharacters(sl<CharacterRepository>()),
  );

  sl.registerFactory<CharacterViewModel>(
    () => CharacterViewModel(sl<GetCharacters>()),
  );
}
