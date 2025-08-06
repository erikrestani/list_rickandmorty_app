import 'package:flutter/material.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: const Center(child: Text('Carregando personagens...')),
    );
  }
}
