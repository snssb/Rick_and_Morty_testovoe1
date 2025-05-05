import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_event.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_state.dart';
import 'package:testovoe1/features/characters/presentation/widgets/character_card.dart';

// class CharactersScreen extends StatelessWidget {
//   const CharactersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Characters Page'));
//   }
// }

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CharactersBloc>();
    if (bloc.state.characters.isEmpty) {
      bloc.add(const FetchCharacters(1));
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<CharactersBloc>();
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8 &&
        !bloc.state.isLoading &&
        bloc.state.hasNextPage) {
      final nextPage = bloc.state.currentPage + 1;
      bloc.add(FetchCharacters(nextPage));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty Characters')),
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.characters.isEmpty) {
            return const Center(child: Text('No characters available.'));
          }

          final characters = state.characters;
          return ListView.builder(
            controller: _scrollController,
            itemCount: characters.length + (state.hasNextPage ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == characters.length && state.hasNextPage) {
                return const Center(child: CircularProgressIndicator());
              }
              final character = characters[index];
              return CharacterCardWidget(character: character, key: ValueKey(character.id));
            },
          );
        },
      ),
    );
  }
}
