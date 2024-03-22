import 'package:flutter/material.dart';
import 'package:nombre_mystere/MyApp.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nombre_mystere/model/sql/bd.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  final init = BD().database;
  runApp(const MyApp());


}

