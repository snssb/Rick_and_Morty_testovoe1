import 'package:testovoe1/features/characters/data/datasources/character_local_datasource.dart';
import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';
import 'package:testovoe1/features/characters/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final CharacterLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> toggleFavorite(int id) async {
    await localDataSource.toggleFavorite(id);
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    final favorites = await localDataSource.getFavorites();
    return favorites.map((model) => model.toEntity()).toList();
  }
}
