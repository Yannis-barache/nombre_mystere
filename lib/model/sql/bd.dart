import 'package:sqflite/sqflite.dart';
import 'dart:async';

Future<void> openDB() async {
  var db = await openDatabase('sqlite.db');
  
  return;
}
