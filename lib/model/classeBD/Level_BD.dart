import 'dart:developer';

import 'package:nombre_mystere/model/classe/level.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LevelBD {
  
  Future<int> insertLevel() async {
    try {
      final db = await BD.instance.database;

      Level level = Level(id: 1, nomLevel: "Facile", rangeMin: 0, rangeMax: 10, nbEssais: 4, avecFloat: false);
      Level level2 = Level(id: 2, nomLevel: "Moyen", rangeMin: 0, rangeMax: 100, nbEssais: 10, avecFloat: false);
      Level level3 = Level(id: 3, nomLevel: "Difficile", rangeMin: -1000, rangeMax: 500, nbEssais: 13, avecFloat: false);
      Level level4 = Level(id: 4, nomLevel: "Extreme", rangeMin: 0, rangeMax: 10, nbEssais: 15, avecFloat: true);

      List<Level> levels = [level, level2, level3, level4];

      log("insertLevel");
      for (Level level in levels) {
        await db.insert(
          'DIFFICULTE',
          level.toMap(),
        );
      }

      return 1;

      
    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  // crée une fonction pour afficher les colonnes de la table
  Future<void> showColumns() async {
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("PRAGMA table_info(DIFFICULTE)");
    log(queryResult.toString());
  }

  Future<List<Level>> getLevels() async { 
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("SELECT * FROM DIFFICULTE");
    log(queryResult.toString());
    return queryResult.map((e) => Level.fromMap(e)).toList();
  
}

   Future<void> createTable(Database db) async{
    await db.execute(
      '''CREATE TABLE DIFFICULTE(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomLevel TEXT NOT NULL,
        rangeMin INTEGER NOT NULL,
        rangeMax INTEGER NOT NULL,
        nbEssais INTEGER NOT NULL,
        avecFloat BOOLEAN NOT NULL
      )'''
    );
    //create(level: Level(id: 1, nomLevel: "Facile", rangeMin: 0, rangeMax: 100, nbEssais: 10, avecFloat: false));
    log("Table created III");
    int result = await insertLevel();
    log("Insert result: $result");
   }


    Future<Level> levelById(int id) async {
    final db = await BD.instance.database;
    final queryResult = await db.rawQuery("SELECT * FROM DIFFICULTE WHERE id = $id");
    log(queryResult.toString());
    return Level.fromMap(queryResult.first);

  }

}