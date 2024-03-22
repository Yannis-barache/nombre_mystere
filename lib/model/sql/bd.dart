import 'package:nombre_mystere/model/classe/Difficulter.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:async';
import 'package:path/path.dart';

class BD {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    return join(await getDatabasesPath(), 'nombre_mystere.db');
  }

  Future<Database> _initialize() async {
    if (Platform.isWindows || Platform.isLinux){
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      return await databaseFactory.openDatabase(
        await fullPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _createDB,
        ),
      );
    }
    return await openDatabase(
      await fullPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  static Future<void> _createDB(Database db, int version) async {
    // Création des tables si elles n'existent pas déjà
    await db.execute(
      'CREATE TABLE IF NOT EXISTS joueur(idJoueur INTEGER PRIMARY KEY AUTOINCREMENT, pseudo TEXT UNIQUE NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS DIFFICULTE(idDifficulte INTEGER PRIMARY KEY AUTOINCREMENT,nomDifficulte TEXT UNIQUE NOT NULL,rangeMin INTEGER NOT NULL,rangeMax INTEGER NOT NULL,nbVirgules BOOLEAN NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS SCORE(idScore INTEGER PRIMARY KEY AUTOINCREMENT,idJoueur INTEGER NOT NULL,idDifficulte INTEGER NOT NULL,essais INTEGER NOT NULL,temps INTEGER NOT NULL,FOREIGN KEY(idJoueur) REFERENCES joueur(idJoueur),FOREIGN KEY(idDifficulte) REFERENCES DIFFICULTE(idDifficulte))',
    );

    await BD.insertJoueur('Abdwu');
    await BD.insertJoueur('YN');

    await BD.insertDifficulte('Facile', 0, 10, 0);
    await BD.insertDifficulte('Moyen', 0, 100, 0);
    await BD.insertDifficulte('Itermediaire', -100, 100, 0);
    await BD.insertDifficulte('Difficile', 0, 15, 1);

    await BD.insertScore(3, 1, 1);



  }

  static Future<void> insertJoueur(String pseudo) async {
    final db = await BD().database;
    await db.rawInsert(
      'INSERT INTO joueur(pseudo) VALUES(?)',
      [pseudo],
    );
  }

  static Future<void> insertDifficulte(
      String nomDifficulte, int rangeMin, int rangeMax, int nbVirgules) async {
    final db = await BD().database;
    await db.rawInsert(
      'INSERT INTO DIFFICULTE(nomDifficulte, rangeMin, rangeMax, nbVirgules) VALUES(?, ?, ?, ?)',
      [nomDifficulte, rangeMin, rangeMax, nbVirgules],
    );
  }

  static Future<void> insertScore(
      int essai, int idJoueur, int idDifficulte) async {
    final db = await BD().database;
    await db.rawInsert(
      'INSERT INTO SCORE(essai, idJoueur, idDifficulte) VALUES(?, ?, ?)',
      [essai, idJoueur, idDifficulte],
    );
  }

  static Future<void> addLevel(Level level) async {
    final db = await BD().database;
    await db.insert('DIFFICULTE', level.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<List<Level>> fetchAllLevel() async {
    final db = await BD().database;
    List<Map<String, dynamic>> result = await db.query('DIFFICULTE');
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

}
