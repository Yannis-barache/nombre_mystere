import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regles'),
      ),
      body: const Center(
        child: Text('Les regles du jeu'),
      ),
    );
  }
}