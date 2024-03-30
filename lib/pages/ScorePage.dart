import 'dart:developer';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classe/joueur.dart';
import 'package:nombre_mystere/model/classe/level.dart';
import 'package:nombre_mystere/model/classe/score.dart';
import 'package:nombre_mystere/model/classeBD/Score_bd.dart';
import 'package:nombre_mystere/model/classeBD/Joueur_BD.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';


class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();

}

class _ScorePageState extends State<ScorePage> {
Future<List<Score>>? _scores;
  final _score = ScoreBD();
  final _joueurBD = JoueurBD();
  final _levelBD = LevelBD();

  int _selectedLevel = 1;
  int _podiem = 3;
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
      _scores = _score.getScoresByLevel(_selectedLevel);
    });
  }


  

  Future<String> chercheNomJoueur(int idJoueur) async {
  Joueur joueurX = Joueur(pseudo: "JoueurX");
   List<Joueur> lstJoueur = await _joueurBD.getJoueurs();
   for (var i = 0; i < lstJoueur.length; i++) {
     if (lstJoueur[i].id == idJoueur) {
       joueurX.pseudo = lstJoueur[i].pseudo;
     }
   }
    return joueurX.pseudo;

  }

  getIconeScore() {
    if (_podiem == 3) {
      _podiem--;
      return Icons.star;
    } else if (_podiem == 2) {
      _podiem--;
      return Icons.star_half;
    } else if (_podiem == 1) {
      _podiem--;
      return Icons.star_border;
    } else {
      // icon random
        final List<IconData> iconData = <IconData>[Icons.call, Icons.school];
        final r = new Random();
        return Icon(iconData[r.nextInt(iconData.length)]).icon;
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Scores'),
          actions: [
            FutureBuilder<List<Level>>(
              future: _levelBD.getLevels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return DropdownButton<int>(
                    value: _selectedLevel,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLevel = newValue!;
                        _podiem = 3;
                        fetchScores();
                      });
                    },
                    items: snapshot.data!
                        .map<DropdownMenuItem<int>>(
                          (level) => DropdownMenuItem<int>(
                            value: level.id,
                            child: Text(level.nomLevel),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
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
            return DataTable(
              columns: const [
                DataColumn(label: Text('Nom du joueur')),
                DataColumn(label: Text('Score')),
                DataColumn(label: Text('Corps')),
              ],
              rows: snapshot.data!.map<DataRow>((score) {
                return DataRow(cells: [
                  DataCell(
                    FutureBuilder<String>(
                      future: chercheNomJoueur(score.idUser),
                      builder: (context, joueurSnapshot) {
                        if (joueurSnapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (joueurSnapshot.hasError) {
                          return Text('Erreur: ${joueurSnapshot.error}');
                        } else if (joueurSnapshot.hasData) {
                          return Text(joueurSnapshot.data!);
                        } else {
                          return const Text('Aucun score');
                        }
                      },
                    ),
                  ),
                  DataCell(Text('${score.nbEssai * _selectedLevel * 8}')),
                  DataCell(Icon(getIconeScore())),
                ]);
              }).toList(),
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
  


