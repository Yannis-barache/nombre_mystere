import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classeBD/Joueur_BD.dart';

class GameOver extends StatelessWidget {
  final String result;
  final int nbEssais;
  GameOver({Key? key,required this.result, required this.nbEssais}) : super(key: key);

  final Map<String, Map<String,String>> _result = {
    'win': {
      'message' : 'Bravo, vous avez trouvé le nombre mystère !',
      'boutonText' : 'Page de level',
      'encouragement' : 'Bien joué !!!!!',
    },
    'perdu': {
      'message' : 'Dommage, vous avez perdu !',
      'boutonText' : 'Page de level',
      'encouragement' : 'Ce n\'est pas grave, vous ferez mieux la prochaine fois !',
    }
    };
  

  void _win() {
    JoueurBD().unlockNextLevel(nbEssais);
  }

        

  @override
  Widget build(BuildContext context) {

    void goToLevel() {
      if (result == 'win') {
        _win();
      }
      context.go('/niveaux');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fin de la partie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((_result[result]?['message'] ?? '')),
            Text((_result[result]?['encouragement'] ?? '')),
            ElevatedButton(onPressed: 
              () {
                goToLevel();
              }
            , child: Text((_result[result]?['boutonText'] ?? ''))
            )
          ],
        ),
      ),
    );
    }








}