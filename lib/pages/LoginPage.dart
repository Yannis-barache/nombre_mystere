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
                connecteUser(_controller.text);
                context.go("/");
              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
