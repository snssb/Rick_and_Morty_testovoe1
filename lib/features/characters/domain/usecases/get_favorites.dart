import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';
import 'package:testovoe1/features/characters/domain/repositories/favorite_repository.dart';

class GetFavorites {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  /// Retrieves all favorite characters.
  Future<List<CharacterEntity>> call() async {
    return await repository.getFavorites();
  }
}
