import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/model/classe/Jeu.dart';
import 'package:flutter/services.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';
import 'package:nombre_mystere/style/input.dart';

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
        log('Nombre mystère : $nombreMystere');
        min = minNiveau;
        max = maxNiveau;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nombre mystère : $nombreMystere',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                min.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputNombre(controller: leController)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                max.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _onPressed,
                child: const Text('Valider'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Essais : $essais',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
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
    debugPrint('Nombre : $nombreStr');
    if (nombreStr.isEmpty || int.tryParse(nombreStr) == null) {
      debugPrint('Invalid number');
      return;
    }
    final int nombre = int.parse(nombreStr);
    log("Nombre : $nombre - min : $minNiveau  -  max : $maxNiveau");
    if (nombre < min! || nombre > max!) {
      setState(() {
        message = 'Le nombre doit être compris entre $min et $max';
        log('Le nombre doit être compris entre $min et $max');
      });
      return;
    }
    final int resultat = Jeu.compareNombre(nombreMystere, nombre);
    if (resultat == 0) {
      debugPrint('Gagné');
    } else {
      setState(() {
        essais = essais + 1;
        if (resultat == 1) {
          max = nombre;
        } else {
          min = nombre;
        }
        message = null;
      });
      if (essais == essaisMax) {
        context.go('/lose');
      }
    }
  }
}