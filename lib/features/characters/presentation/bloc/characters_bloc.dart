import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';
import 'package:testovoe1/features/characters/domain/usecases/get_characters.dart';
import 'package:testovoe1/features/characters/domain/usecases/get_favorites.dart';
import 'package:testovoe1/features/characters/domain/usecases/toggle_favorite.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_event.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;
  final ToggleFavorite toggleFavorite;
  final GetFavorites getFavorites;

  CharactersBloc({required this.getCharacters, required this.toggleFavorite, required this.getFavorites})
    : super(const CharactersState()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<FetchFavorites>(_onFetchFavorites);
  }

  Future<void> _onFetchCharacters(FetchCharacters event, Emitter<CharactersState> emit) async {
    if (!state.hasNextPage && event.page > state.currentPage) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await getCharacters(event.page);
      final newCharacters = result['characters'] as List<CharacterEntity>;
      final info = result['info'] as Map<String, dynamic>;
      final hasNextPage = info['next'] != null;

      final updatedCharacters = event.page == 1 ? newCharacters : [...state.characters, ...newCharacters];

      emit(
        state.copyWith(
          characters: updatedCharacters,
          isLoading: false,
          hasNextPage: hasNextPage,
          currentPage: event.page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<CharactersState> emit) async {
    try {
      await toggleFavorite(event.characterId);

      final updatedCharacters =
          state.characters.map((character) {
            if (character.id == event.characterId) {
              final newFavoriteStatus = !character.isFavorite;
              return character.copyWith(isFavorite: newFavoriteStatus);
            }
            return character;
          }).toList();

      final updatedFavorites =
          updatedCharacters.where((character) => character.isFavorite).toList()
            ..sort((a, b) => a.name.compareTo(b.name));
      ;

      emit(state.copyWith(characters: updatedCharacters, favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchFavorites(FetchFavorites event, Emitter<CharactersState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final favorites = await getFavorites();
      emit(state.copyWith(favorites: favorites, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
