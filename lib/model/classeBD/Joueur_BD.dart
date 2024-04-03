import 'dart:developer';

import 'package:nombre_mystere/model/classe/joueur.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:nombre_mystere/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nombre_mystere/model/classe/score.dart';
import 'package:nombre_mystere/model/classeBD/Score_BD.dart';


class JoueurBD{

  Future<int> createTable(Database db) async {
    try {

      await db.execute(
        '''CREATE TABLE JOUEUR(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pseudo TEXT NOT NULL UNIQUE,
          currentLevel INTEGER NOT NULL DEFAULT 1
        )'''
      );

      return 1;
      
    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  Future<List<Joueur>> getAllJoueurs() async {
    try {
      final db = await BD.instance.database;
      final queryResult = await db.rawQuery("SELECT * FROM JOUEUR");
      log(queryResult.toString());
      return queryResult.map((e) => Joueur.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      return [Joueur(pseudo: "error")];
    }
  }

  Future<int> insertTestJoueur() async {
    try {
      final db = await BD.instance.database;
      Joueur joueur = Joueur(pseudo: 'test');
      await db.rawInsert(
        '''INSERT INTO JOUEUR(pseudo) VALUES(?)''',
        [joueur.pseudo]
      );

      Joueur joueur2 = Joueur.withId(id: 2, pseudo: "test2", currLevel: 2)
;      await db.rawInsert(
          '''INSERT INTO JOUEUR(pseudo, currentLevel) VALUES(?,?)''',
          [joueur2.pseudo, joueur2.currLevel]
      );


      log("Insert II");

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
      await insertJoueur(Joueur(pseudo: username));
      final cherche = await db.rawQuery("SELECT * FROM JOUEUR WHERE pseudo = '$username'");
      final jTrouve  = Joueur.fromMap(cherche.first);
      leJoueur.pseudo = jTrouve.pseudo;
      leJoueur.id = jTrouve.id;
      leJoueur.currLevel = jTrouve.currLevel;
      return 1;
    }
    log(Joueur.fromMap(queryResult.first).toString());
    final jTrouve  = Joueur.fromMap(queryResult.first);
    leJoueur.pseudo = jTrouve.pseudo;
    leJoueur.id = jTrouve.id;
    leJoueur.currLevel = jTrouve.currLevel;
    return 1;
  } catch (e) {
    log(e.toString());
    return -1;
  }
}

Future<int> unlockNextLevel(idNiv,nbEssai) async{
  if (leJoueur.id == -1) {
    return -1;
  }

  try {
    final score = nbEssai * leJoueur.currLevel;
    const maxLevel = 4;
    final db = await BD.instance.database;

    if (leJoueur.currLevel >= maxLevel) {
      return 1;
    }

    ScoreBD().insertScore(Score(idScore: 1,idLevel: idNiv, idUser: leJoueur.id, nbEssai: nbEssai));

    if (idNiv >= leJoueur.currLevel) {
      leJoueur.currLevel = idNiv+1;
    }
    await db.rawQuery("UPDATE JOUEUR SET currentLevel = ${leJoueur.currLevel} WHERE id = ${leJoueur.id}");
    return 1;

  } catch (e) {
    log(e.toString());
    return -1;  
  }

}

}