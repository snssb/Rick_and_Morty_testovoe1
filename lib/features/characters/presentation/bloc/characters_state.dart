import 'package:equatable/equatable.dart';
import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';

class CharactersState extends Equatable {
  final List<CharacterEntity> characters;
  final List<CharacterEntity> favorites;
  final bool isLoading;
  final String? errorMessage;
  final bool hasNextPage;
  final int currentPage;

  const CharactersState({
    this.characters = const [],
    this.favorites = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasNextPage = true,
    this.currentPage = 0,
  });

  CharactersState copyWith({
    List<CharacterEntity>? characters,
    List<CharacterEntity>? favorites,
    bool? isLoading,
    String? errorMessage,
    bool? hasNextPage,
    int? currentPage,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [characters, favorites, isLoading, errorMessage, hasNextPage, currentPage];
}
