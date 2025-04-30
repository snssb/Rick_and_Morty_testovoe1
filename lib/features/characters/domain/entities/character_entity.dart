import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String gender;
  final String image;
  bool isFavorite;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    this.isFavorite = false,
  });

  CharacterEntity copyWith({int? id, String? name, String? gender, String? image, bool? isFavorite}) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, name, gender, image, isFavorite];
}
