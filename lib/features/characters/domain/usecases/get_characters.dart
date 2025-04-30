import 'package:testovoe1/features/characters/domain/repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  /// Fetches characters for the given page.
  Future<Map<String, dynamic>> call(int page) async {
    return await repository.getCharacters(page);
  }
}
