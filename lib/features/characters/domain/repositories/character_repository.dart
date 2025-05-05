abstract class CharacterRepository {
  Future<Map<String, dynamic>> getCharacters(int page);
}
