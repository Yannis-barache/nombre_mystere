import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';
import 'package:nombre_mystere/model/classeBD/Joueur_BD.dart';
import 'package:nombre_mystere/model/classeBD/Score_BD.dart';

import 'dart:async';

class BD {
  static final BD instance = BD._init();
  static Database? _database;

  BD._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ttttt.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // reprendre la bd du fichier sqlitebd dans le même dossier
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    final db = await openDatabase(path, version: 1, onCreate: createDB);
    return db;
  }


  Future<void> createDB(Database db, int version) async {
    try {
      await db.execute(
        '''CREATE TABLE JOUEUR(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pseudo TEXT NOT NULL UNIQUE
        )'''
      );

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

      await db.execute('''
        CREATE TABLE Score(
          idScore INTEGER PRIMARY KEY AUTOINCREMENT,
          idLevel INTEGER NOT NULL,
          idUser INTEGER NOT NULL,
          nbEssai INTEGER NOT NULL,
          FOREIGN KEY(idLevel) REFERENCES Level(idLevel),
          FOREIGN KEY(idUser) REFERENCES Joueur(id)
        )
      ''');

      LevelBD().insertLevel();
      JoueurBD().insertTestJoueur();
      ScoreBD().insertTestScore();
    } catch (e) {
      log(e.toString());
    }

  }


}

  