import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/features/characters/domain/entities/character.dart';
import 'package:list_rickandmorty_app/features/characters/presentation/widgets/character_card.dart';
import 'package:list_rickandmorty_app/shared/loading_widget.dart';
import 'package:list_rickandmorty_app/shared/scroll_to_top_button.dart';

class CharacterListContent extends StatelessWidget {
  final List<Character> characters;
  final bool isLoading;
  final ScrollController scrollController;
  final Function(Character) onCharacterTap;

  const CharacterListContent({
    super.key,
    required this.characters,
    required this.isLoading,
    required this.scrollController,
    required this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return CharacterCard(
                    character: character,
                    onTap: () => onCharacterTap(character),
                  );
                },
              ),
            ),
            if (isLoading)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(child: LoadingWidget(size: 30)),
              ),
          ],
        ),
        ScrollToTopButton(scrollController: scrollController),
      ],
    );
  }
}
