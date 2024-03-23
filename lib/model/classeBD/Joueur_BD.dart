import 'dart:developer';

import 'package:nombre_mystere/model/classe/joueur.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:nombre_mystere/const.dart';
import 'package:sqflite/sqflite.dart';

class JoueurBD{

  Future<int> createTable(Database db) async {
    try {

      await db.execute(
        '''CREATE TABLE JOUEUR(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pseudo TEXT NOT NULL UNIQUE
        )'''
      );

      return 1;
      
    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  Future<int> insertJoueur(Joueur joueur) async {
    try {
      final db = await BD.instance.database;

      await db.rawInsert(
        '''INSERT INTO JOUEUR(pseudo) VALUES(?)''',
        [joueur.pseudo]
      );

      return 1;

      
    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  Future<void> showColumns() async {
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("PRAGMA table_info(JOUEUR)");
    log(queryResult.toString());
  }

  Future<List<Joueur>> getJoueurs() async { 
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("SELECT * FROM JOUEUR");
    log(queryResult.toString());
    return queryResult.map((e) => Joueur.fromMap(e)).toList();

}


Future<int> loginUser(String username) async {
  try {
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("SELECT * FROM JOUEUR WHERE pseudo = '$username'");
    if (queryResult.isEmpty) {
      insertJoueur(Joueur(pseudo: username));
      final cherche = await db.rawQuery("SELECT * FROM JOUEUR WHERE pseudo = '$username'");
      leJoueur = Joueur.fromMap(cherche.first);
      return 1;
    }
    log(Joueur.fromMap(queryResult.first).toString());
    leJoueur = Joueur.fromMap(queryResult.first);
    return 1;
  } catch (e) {
    log(e.toString());
    return -1;
  }
}

}