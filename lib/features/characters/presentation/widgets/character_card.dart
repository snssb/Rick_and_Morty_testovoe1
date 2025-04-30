import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_event.dart';

class CharacterCardWidget extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCardWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(character.image)),
      title: Text(character.name),
      subtitle: Text(character.gender),
      trailing: IconButton(
        icon: Icon(
          character.isFavorite ? Icons.star : Icons.star_border,
          color: character.isFavorite ? Colors.amber : null,
        ),
        onPressed: () {
          context.read<CharactersBloc>().add(ToggleFavoriteEvent(character.id));
        },
      ),
    );
  }
}
