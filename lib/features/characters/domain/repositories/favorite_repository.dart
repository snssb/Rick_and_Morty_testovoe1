import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';

abstract class FavoriteRepository {
  Future<void> toggleFavorite(int id);
  Future<List<CharacterEntity>> getFavorites();
}
