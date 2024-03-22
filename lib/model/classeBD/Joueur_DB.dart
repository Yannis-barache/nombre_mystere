import 'package:nombre_mystere/model/Joueur.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:sqflite/sqflite.dart';

class JoueurBD{

  Future<int> create(Joueur joueur) async {
    final db = await BD().database;
    final pseudo = joueur.pseudo;
    return await db.rawInsert(
      'INSERT INTO joueur(pseudo) VALUES(?)',
      [pseudo]
    );

  }

}