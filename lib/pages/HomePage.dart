import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre Mystere'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => context.go('/niveau'),
                child: Text('Jouer')),
            ElevatedButton(
                onPressed: () => context.go('/regles'),
                child: Text('Afficher les scores')),
            ElevatedButton(
                onPressed: () => context.go('/regles') ,
                child: Text('Regles')),
          ],
        ),
      ),
    );
  }
}