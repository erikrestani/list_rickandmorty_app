import 'package:test_fteam/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.image,
    required super.status,
    required super.species,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      species: json['species'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'species': species,
    };
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
    );
  }
}
