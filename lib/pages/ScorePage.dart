import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classe/joueur.dart';
import 'package:nombre_mystere/model/classe/score.dart';
import 'package:nombre_mystere/model/classeBD/Score_bd.dart';
import 'package:nombre_mystere/model/classeBD/Joueur_BD.dart';


class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();

}

class _ScorePageState extends State<ScorePage> {
  Future<List<Score>>? _scores;
  final _score = ScoreBD();
  final lesJoueurs = JoueurBD().getAllJoueurs();

  @override
  void initState() {
    super.initState();
    fetchScores();
  }

  void fetchScores() {
    if (leJoueur.id == -1) {
      context.go('/login');
    }
    setState(() {
      _scores = _score.getScores();
    });


  }

  Future<String> chercheNomJoueur(int idJoueur) async {
  Joueur joueurX = Joueur(pseudo: "JoueurX");
   List<Joueur> lstJoueur = await lesJoueurs;
   for (var i = 0; i < lstJoueur.length; i++) {
     if (lstJoueur[i].id == idJoueur) {
      log("Joueur trouvé : ${lstJoueur[i].pseudo}");
       joueurX.pseudo = lstJoueur[i].pseudo;
     }
   }
    return joueurX.pseudo;

  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Scores'),
    ),
    body: FutureBuilder<List<Score>>(
      future: _scores,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final score = snapshot.data![index];
              return FutureBuilder<String>(
                future: chercheNomJoueur(score.idUser),
                builder: (context, joueurSnapshot) {
                  if (joueurSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (joueurSnapshot.hasError) {
                    return Text('Erreur: ${joueurSnapshot.error}');
                  } else if (joueurSnapshot.hasData) {
                    final nomJoueur = joueurSnapshot.data!;
                    return ListTile(
                      title: Text('Joueur: $nomJoueur, Level: ${score.idLevel}'),
                      subtitle: Text('Nombre d\'essais restant : ${score.nbEssai}'),
                    );
                  } else {
                    return const Text('Aucun score');
                  }
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text('Aucun score'),
          );
        }
      },
    ),
  );
}


}