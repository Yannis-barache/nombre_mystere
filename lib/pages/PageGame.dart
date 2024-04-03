import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classe/Jeu.dart';
import 'package:flutter/services.dart';
import 'package:nombre_mystere/model/classeBD/Score_BD.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';
import 'package:nombre_mystere/style/input.dart';

import '../model/classe/Score.dart';

class PageGame extends StatefulWidget {
  final int idNiveau;

  const PageGame({
    Key? key,
    required this.idNiveau,
  }) : super(key: key);

  @override
  _PageGameState createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {
  final TextEditingController leController = TextEditingController();
  final LevelBD levelBD = LevelBD();
  int? maxNiveau;
  int? minNiveau;
  int? nombreMystere;
  int? essaisMax;

  int essais = 0;
  int? min;
  int? max;
  String? message;

  @override
  void initState() {
    super.initState();
    fetchLevel();
  }

  void fetchLevel() {
    levelBD.levelById(widget.idNiveau).then((value) {
      setState(() {
        maxNiveau = value.rangeMax;
        minNiveau = value.rangeMin;
        nombreMystere = Jeu.generateNombre(minNiveau!, maxNiveau!);
        essaisMax = value.nbEssais;
        essais = essaisMax!;
        log('Nombre mystère : $nombreMystere');
        min = minNiveau;
        max = maxNiveau;
      });
    });
  }

  int get essaisRestants => essaisMax != null ? essaisMax! - essais : 0;

  String get niveauDifficulte {
    if (widget.idNiveau == 1) {
      return 'Facile';
    } else if (widget.idNiveau == 2) {
      return 'Moyen';
    } else if (widget.idNiveau == 3) {
      return 'Difficile';
    }
    return 'Extreme';
  }

  @override
  Widget build(BuildContext context) {
    log('Niveau : ${widget.idNiveau}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Trouvez le nombre mystère',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  niveauDifficulte,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        min.toString() + " < ",
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputNombre(controller: leController),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        " < " + max.toString(),
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _onPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    'Valider',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'Essais restants : $essais',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              if (message != null)
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    leController.dispose();
    super.dispose();
  }

  void _onPressed() {
    final String nombreStr = leController.text;
    leController.clear();
    debugPrint('Nombre : $nombreStr');
    if (nombreStr.isEmpty || int.tryParse(nombreStr) == null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Veuillez entrer un nombre valide',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
      return;
    }
    final int nombre = int.parse(nombreStr);
    log("Nombre : $nombre - min : $minNiveau  -  max : $maxNiveau");
    if (nombre < min! || nombre > max!) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Le nombre doit être compris entre $min et $max',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
      return;
    }
    final int resultat = Jeu.compareNombre(nombreMystere, nombre);
    if (resultat == 0) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'C\'est gagné !',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        context.go('/gameover/${widget.idNiveau}/win/${essais}');
      }
      );
    } else {
      setState(() {
        essais = essais + 1;
        if (resultat == 1) {
          max = nombre;
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Le chiffre est plus petit',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        } else {
          min = nombre;
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Le chiffre est plus grand',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        }
        message = null;
      });
      if (essais == essaisMax) {
        context.go('/gameover/perdu/${essais}');
      }
    }
  }
}