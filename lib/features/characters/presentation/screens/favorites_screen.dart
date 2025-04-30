import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_event.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_state.dart';
import 'package:testovoe1/features/characters/presentation/widgets/character_card.dart';

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Favorites Page'));
//   }
// }

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch favorites
    context.read<CharactersBloc>().add(const FetchFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Characters')),
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.favorites.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.favorites.isEmpty) {
            return const Center(child: Text('No favorite characters yet.'));
          }
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final character = state.favorites[index];
              return CharacterCardWidget(character: character);
            },
          );
        },
      ),
    );
  }
}
