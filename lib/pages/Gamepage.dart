import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/style/input.dart';


class GamePage extends StatefulWidget {
  final int idNiveau;
  // constructeur avec un id du niveau choisis
  const GamePage({Key? key, required this.idNiveau}) : super(key: key);


  @override
  State<GamePage> createState() => FindNumber();
}

class FindNumber extends State<GamePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String niveauText = '';
  String nomNiveau = '';
  int rangeMin = 0;
  int rangeMax = 0;
  int nbEssais = 0;
  int currentRangeMin = 0;
  int currentRangeMax = 0;
  String nomUser = leJoueur.pseudo;

  double calculateTextSize(BuildContext context, double screenHeight) {
    // Calculer la taille du texte en fonction de la hauteur de l'écran
    return 0.04 * screenHeight; // 4% de la hauteur de l'écran
  }

  // Fonction pour récupérer les données depuis la base de données et les afficher
  Future<void> displayDataFromDB() async {



  }

  @override
  void initState() {
    super.initState();
    // Appel de la fonction pour récupérer et afficher les données au démarrage du widget

    // fetch le level avec l'id
    fetchLevel();

  }

  void fetchLevel() {
      LevelBD.levelById(widget.idNiveau).then((value) {
        setState(() {
          niveauText = value.nomLevel;
          nomNiveau = value.nomLevel;
          rangeMin = value.rangeMin;
          rangeMax = value.rangeMax;
          nbEssais = value.nbEssais;
          currentRangeMin = value.rangeMin;
          currentRangeMax = value.rangeMax;
        });
      });

      log(
        "fetchLevel: $niveauText, $nomNiveau, $rangeMin, $rangeMax, $nbEssais"
      );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('jeu'),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '$currentRangeMin <',
                    style: TextStyle(
                      fontSize: calculateTextSize(context, screenHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: InputNombre(),
                    ),
                  ),
                  Text(
                    '<$currentRangeMax  ',
                    style: TextStyle(
                      fontSize: calculateTextSize(context, screenHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
            child:
            Container(
              // centrer les elements
              alignment: Alignment.center,
              width: screenWidth,
              height: screenHeight * 0.7,
              decoration: const BoxDecoration(
                color: Color(0xFFABB1B6),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 1,
                    childAspectRatio: 3.5,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                        const Text(
                          'Niveau',
                          style: TextStyle(
                            fontSize: 32, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                         Text(
                          nomNiveau,
                          style: const TextStyle  (
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Essai Restant',
                          style: TextStyle(
                            fontSize: 32, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '$nbEssais',
                          style: const TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Nom',
                          style: TextStyle(
                            fontSize: 32, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                    const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      Text(
                          nomUser,
                          style: const TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}