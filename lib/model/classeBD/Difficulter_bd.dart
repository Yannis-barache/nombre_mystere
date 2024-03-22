import 'package:nombre_mystere/model/Joueur.dart';
import 'package:nombre_mystere/model/sql/bd.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nombre_mystere/model/Difficulter.dart';
class DiffBD{

  Future<List<Level>> fetchAllLevel() async {
    final db = await BD().database;
    final result = await db.rawQuery(
      'SELECT * FROM level'
    );
    return result.map((level) => Level.fromSqfliteDatabase(level)).toList();
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