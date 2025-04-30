abstract class CharactersEvent {
  const CharactersEvent();
}

class FetchCharacters extends CharactersEvent {
  final int page;

  const FetchCharacters(this.page);
}

class ToggleFavoriteEvent extends CharactersEvent {
  final int characterId;

  const ToggleFavoriteEvent(this.characterId);
}

class FetchFavorites extends CharactersEvent {
  const FetchFavorites();
}

class ResetCharacters extends CharactersEvent {
  const ResetCharacters();
}
