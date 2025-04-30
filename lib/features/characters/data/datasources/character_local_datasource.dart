import 'package:isar/isar.dart';
import 'package:testovoe1/features/characters/data/models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCachedCharacters();
  Future<void> toggleFavorite(int id);
  Future<List<CharacterModel>> getFavorites();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Isar isar;

  CharacterLocalDataSourceImpl(this.isar);

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    try {
      await isar.write((txn) async {
        // Fetch existing characters to preserve isFavorite
        final existingCharacters = txn.characterModels.where().findAll();

        final existingCharactersMap = {for (var char in existingCharacters) char.id: char};

        // Update characters with preserved isFavorite
        final updatedCharacters =
            characters.map((character) {
              final existingCharacter = existingCharactersMap[character.id];
              return CharacterModel(
                id: character.id,
                name: character.name,
                gender: character.gender,
                image: character.image,
                isFavorite: existingCharacter?.isFavorite ?? false,
              );
            }).toList();

        txn.characterModels.putAll(updatedCharacters);
      });
    } catch (e) {
      throw Exception('Failed to cache characters: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    try {
      final characters = isar.characterModels.where().findAll();
      return characters;
    } catch (e) {
      throw Exception('Failed to get cached characters: $e');
    }
  }

  @override
  Future<void> toggleFavorite(int id) async {
    try {
      await isar.write((txn) async {
        final character = txn.characterModels.get(id);
        if (character != null) {
          character.isFavorite = !character.isFavorite;
          txn.characterModels.put(character);
        } else {
          throw Exception('Character with id $id not found');
        }
      });
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getFavorites() async {
    try {
      final favorites = isar.characterModels.where().isFavoriteEqualTo(true).sortByName().findAll();
      return favorites;
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }
}
