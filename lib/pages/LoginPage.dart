import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classeBD/Joueur_BD.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

   int connecteUser(String username) {
    if (username.isEmpty) {
      log("Nom d'utilisateur vide");
      return -1;
    }
    leJoueur.pseudo = username;
    JoueurBD().loginUser(username);
    log("${leJoueur.pseudo} est connecté , id = ${leJoueur.id}");
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login Page'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom d\'utilisateur',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // vérifier si le joueur est connecté
                var etat = connecteUser(_controller.text);
                debugPrint('Etat : $etat');
                if (etat == 0) {
                  // si le joueur est connecté, on le redirige vers la page d'accueil
                  context.go('/niveaux');
                }
                else {
                  // si le joueur n'est pas connecté, on affiche un message d'erreur
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erreur lors de la connexion'),
                    ),
                  );

                }



              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
