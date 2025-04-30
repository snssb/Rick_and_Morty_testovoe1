import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testovoe1/features/characters/domain/entities/character_entity.dart';

part 'character_model.g.dart';

@collection
@JsonSerializable()
class CharacterModel {
  @Id()
  final int id;
  final String name;
  final String gender;
  final String image;
  bool isFavorite;

  CharacterModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    this.isFavorite = false,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterEntity toEntity() =>
      CharacterEntity(id: id, name: name, gender: gender, image: image, isFavorite: isFavorite);

  factory CharacterModel.fromEntity(CharacterEntity entity) => CharacterModel(
    id: entity.id,
    name: entity.name,
    gender: entity.gender,
    image: entity.image,
    isFavorite: entity.isFavorite,
  );
}
