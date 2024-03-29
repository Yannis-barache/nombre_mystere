import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classe/score.dart';
import 'package:nombre_mystere/model/classeBD/Score_bd.dart';


class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();

}

class _ScorePageState extends State<ScorePage> {
  Future<List<Score>>? _scores;
  final _score = ScoreBD();

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
      _scores = _score.getScoresByJoueur(leJoueur.id);
    });

    _scores!.then((value) {
      print(value);
    });
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
                return ListTile(
                  title: Text('Level: ${score.idLevel}'),
                  subtitle: Text('Nombre d\'essais restant : ${score.nbEssai}'),
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