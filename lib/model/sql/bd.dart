import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';
import 'dart:async';

class BD {
  static final BD instance = BD._init();
  static Database? _database;

  BD._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sqlite.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // reprendre la bd du fichier sqlitebd dans le même dossier
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    final db = await openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }


  Future<void> _createDB(Database db, int version) async {
    await LevelBD().createTable(db);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }


}

  