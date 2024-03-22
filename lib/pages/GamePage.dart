import 'package:flutter/material.dart';
import 'package:nombre_mystere/style/input.dart';
import 'package:nombre_mystere/model/sql/bd.dart';


class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => FindNumber();
}

class FindNumber extends State<GamePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String niveauText = '';
  String essaiRestantText = '';
  String nomText = '';

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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String test = niveauText;

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
              height: screenHeight * 0.2,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '5 <',
                    style: TextStyle(
                      fontSize: calculateTextSize(context, screenHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: InputNombre(),
                    ),
                  ),
                  Text(
                    '< 5 ',
                    style: TextStyle(
                      fontSize: calculateTextSize(context, screenHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
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
                        const Text(
                          '2',
                          style: TextStyle(
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
                        const Text(
                          '5',
                          style: TextStyle(
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
                      const Text(
                          'Abdwu',
                          style: TextStyle(
                            fontSize: 35, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '$niveauText 258' ,
                          style: const TextStyle(
                            fontSize: 32, // Taille fixe pour le moment
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                ),
              ),

          ],
        ),
      ),
    );
  }
}
