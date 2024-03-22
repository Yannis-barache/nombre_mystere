import 'package:nombre_mystere/model/classe/Joueur.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';
import 'package:nombre_mystere/model/classe/Difficulter.dart';
class DiffBD{

  Future<List<Level>> fetchAllLevel() async {
    final db = await BD().database;
    List<Map<String, dynamic>> result = await db.query('level');
    if (result.isNotEmpty) {
      return result.map((level) => Level.fromSqfliteDatabase(level)).toList();
    }
    return [
      Level(id: 0, nomLevel: "nonTrouve", rangeMin: 0, rangeMax: 10, nbEssais: 5, avecFloat: false)
    ];

    //final result = await db.rawQuery(
    //  'SELECT * FROM DIFFICULTE;'
    //);
    //return result.map((level) => Level.fromSqfliteDatabase(level)).toList();
  }

  Future<Level> fetchLevelById(int id) async {
    final db = await BD().database;
    final result = await db.rawQuery(
      'SELECT * FROM level WHERE id = ?',
      [id]
    );
    return Level.fromSqfliteDatabase(result.first);
  }



}