import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  

  bool isUserConnected() {
    return leJoueur.id != -1;
  }


  @override
  Widget build(BuildContext context) {

   void goIfUser(String path) {
    if (isUserConnected()) {
      context.go(path);
    } else {
      context.go('/login');
    }
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre Mystere'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => {
                  // verifier si le joueur est connecté
                  goIfUser('/niveaux'),
                },
                child: const Text('Jouer')),
            ElevatedButton(
                onPressed: () => goIfUser('/score/1'),
                child: const Text('Afficher les scores')),
            ElevatedButton(
                onPressed: () => goIfUser('/regles'),
                child: const Text('Regles')),
          ],
        ),
      ),
    );
  }
}