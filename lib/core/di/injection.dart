import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:testovoe1/core/network/network_info.dart';
import 'package:testovoe1/features/characters/data/datasources/character_local_datasource.dart';
import 'package:testovoe1/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:testovoe1/features/characters/data/repositories.dart/character_repository_impl.dart';
import 'package:testovoe1/features/characters/data/repositories.dart/favorite_repository_impl.dart';
import 'package:testovoe1/features/characters/domain/repositories/character_repository.dart';
import 'package:testovoe1/features/characters/domain/repositories/favorite_repository.dart';
import 'package:testovoe1/features/characters/domain/usecases/get_characters.dart';
import 'package:testovoe1/features/characters/domain/usecases/get_favorites.dart';
import 'package:testovoe1/features/characters/domain/usecases/toggle_favorite.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies(Isar isar) async {
  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Isar>(() => isar);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<Connectivity>()));

  // Data
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(dio: sl<Dio>(), networkInfo: sl<NetworkInfo>()),
  );
  sl.registerLazySingleton<CharacterLocalDataSource>(() => CharacterLocalDataSourceImpl(sl<Isar>()));
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: sl<CharacterRemoteDataSource>(),
      localDataSource: sl<CharacterLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(localDataSource: sl<CharacterLocalDataSource>()),
  );

  // Domain
  sl.registerLazySingleton<GetCharacters>(() => GetCharacters(sl<CharacterRepository>()));
  sl.registerLazySingleton<ToggleFavorite>(() => ToggleFavorite(sl<FavoriteRepository>()));
  sl.registerLazySingleton<GetFavorites>(() => GetFavorites(sl<FavoriteRepository>()));

  // Presentation
  sl.registerLazySingleton<CharactersBloc>(
    () => CharactersBloc(
      getCharacters: sl<GetCharacters>(),
      toggleFavorite: sl<ToggleFavorite>(),
      getFavorites: sl<GetFavorites>(),
    ),
  );
}
