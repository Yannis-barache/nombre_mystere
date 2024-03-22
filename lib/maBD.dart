import 'package:sqflite/sqflite.dart';

class DB{

  final Database instanceBD;

  DB({required this.instanceBD});

  String createBD() {


    instanceBD.execute(
      'CREATE TABLE IF NOT EXISTS joueur(idJoueur INTEGER PRIMARY KEY AUTOINCREMENT, pseudo TEXT UNIQUE NOT NULL)',
    );
    instanceBD.execute(
      'CREATE TABLE IF NOT EXISTS DIFFICULTE(idDifficulte INTEGER PRIMARY KEY AUTOINCREMENT,nomDifficulte TEXT UNIQUE NOT NULL,rangeMin INTEGER NOT NULL,rangeMax INTEGER NOT NULL,nbVirgules BOOLEAN NOT NULL)',
    );
    instanceBD.execute(
      'CREATE TABLE IF NOT EXISTS SCORE(idScore INTEGER PRIMARY KEY AUTOINCREMENT,idJoueur INTEGER NOT NULL,idDifficulte INTEGER NOT NULL,essais INTEGER NOT NULL,temps INTEGER NOT NULL,FOREIGN KEY(idJoueur) REFERENCES joueur(idJoueur),FOREIGN KEY(idDifficulte) REFERENCES DIFFICULTE(idDifficulte))',
    );





    return 'Table nombre_mystere created';

  } 




}