import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Map<String, dynamic>> getCharacters(int page);
  Future<void> toggleFavorite(int id);
  Future<List<CharacterEntity>> getFavorites();
}
