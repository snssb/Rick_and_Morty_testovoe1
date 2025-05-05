import 'package:testovoe1/features/characters/domain/repositories/favorite_repository.dart';

class ToggleFavorite {
  final FavoriteRepository repository;

  ToggleFavorite(this.repository);

  /// Toggles the favorite status of a character by ID.
  Future<void> call(int id) async {
    await repository.toggleFavorite(id);
  }
}
