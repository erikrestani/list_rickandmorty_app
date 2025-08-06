import 'package:test_fteam/features/characters/domain/entities/character.dart';

class TestHelper {
  static const Character sampleCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    status: 'Alive',
    species: 'Human',
  );

  static const List<Character> sampleCharacters = [
    Character(
      id: 1,
      name: 'Rick Sanchez',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      status: 'Alive',
      species: 'Human',
    ),
    Character(
      id: 2,
      name: 'Morty Smith',
      image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      status: 'Alive',
      species: 'Human',
    ),  
    Character(
      id: 3,
      name: 'Summer Smith',
      image: 'https://rickandmortyapi.com/api/character/avatar/3.jpeg',
      status: 'Alive',
      species: 'Human',
    ),
  ];

  static Map<String, dynamic> get sampleCharacterJson => {
        'id': 1,
        'name': 'Rick Sanchez',
        'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        'status': 'Alive',
        'species': 'Human',
      };

  static List<Map<String, dynamic>> get sampleCharactersJson => [
        {
          'id': 1,
          'name': 'Rick Sanchez',
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'status': 'Alive',
          'species': 'Human',
        },
        {
          'id': 2,
          'name': 'Morty Smith',
          'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
          'status': 'Alive',
          'species': 'Human',
        },
      ];

  static Future<void> waitFor(Duration duration) async {
    await Future.delayed(duration);
  }

  static Character createCharacter({
    int? id,
    String? name,
    String? image,
    String? status,
    String? species,
  }) {
    return Character(
      id: id ?? sampleCharacter.id,
      name: name ?? sampleCharacter.name,
      image: image ?? sampleCharacter.image,
      status: status ?? sampleCharacter.status,
      species: species ?? sampleCharacter.species,
    );
  }
} 