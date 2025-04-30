import 'package:testovoe1/features/characters/domain/repositories/character_repository.dart';

class ToggleFavorite {
  final CharacterRepository repository;

  ToggleFavorite(this.repository);

  /// Toggles the favorite status of a character by ID.
  Future<void> call(int id) async {
    await repository.toggleFavorite(id);
  }
}
