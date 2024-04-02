import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:nombre_mystere/model/classe/score.dart';
import 'dart:developer';


class ScoreBD {
  

  insertTestScore() async {
    try {
      final db = await BD.instance.database;
      await db.rawInsert('''
        INSERT INTO Score(idLevel, idUser, nbEssai) VALUES(1, 1, 5)
      ''');

      log("Insert III");

    } catch (e) {
      log(e.toString());
      return -1;
    }
  }


  Future<int> insertScore(Score score) async {
    try {
      final db = await BD.instance.database;

      await db.rawInsert(
        '''INSERT INTO Score(idLevel, idUser, nbEssai) VALUES(?,?,?)''',
        [score.idLevel, score.idUser, score.nbEssai]
      );

      return 1;

      
    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  Future<int> insertScoreMap(int idLevel, int idUser, int nbEssai) async {
    try {
      final db = await BD.instance.database;

      await db.rawInsert(
        '''INSERT INTO Score(idLevel, idUser, nbEssai) VALUES(?,?,?)''',
        [idLevel, idUser, nbEssai]
      );

      return 1;


    } catch (e) {
        log(e.toString());
        return -1;
    }
  }

  Future<void> showColumns() async {
    try {
      final db = await BD.instance.database;
      final queryResult = await db.rawQuery("PRAGMA table_info(Score)");
      log(queryResult.toString());
    } catch (e) {
      log(e.toString());
    }
  }

    Future<List<Score>> getScoresByLevel(idLevel) async { 
      try{
        final db = await BD.instance.database;
        final queryResult = await db.rawQuery("SELECT * FROM Score WHERE idLevel = $idLevel ORDER BY nbEssai DESC");
        log(queryResult.toString());
        return queryResult.map((e) => Score.fromJson(e)).toList();
      } catch (e) {
        log(e.toString());
        return [Score(idScore: -1, idLevel: -1, idUser: -1, nbEssai: -1)];
      }
        
    }

  Future<List<Score>> getScores() async { 
    try {
        final db = await BD.instance.database;
        final queryResult = await db.rawQuery("SELECT * FROM Score");
        log(queryResult.toString());
        return queryResult.map((e) => Score.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return [Score(idScore: -1, idLevel: -1, idUser: -1, nbEssai: -1)];
    }

  }

  Future<List<Score>> getScoresByJoueur(int idUser) async { 
    try {
        final db = await BD.instance.database;
        final queryResult = await db.rawQuery("SELECT * FROM Score WHERE idUser = $idUser");
        // log(queryResult.toString());
        // log("${queryResult.map((e) => Score.fromJson(e)).toList()}");
        return queryResult.map((e) => Score.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return [Score(idScore: -1, idLevel: -1, idUser: -1, nbEssai: -1)];
    }

  }




    }