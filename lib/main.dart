import 'package:flutter/material.dart';
import 'package:nombre_mystere/model/sql/bd.dart';

import 'package:nombre_mystere/MyApp.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  
  BD.instance.database;

  runApp(const MyApp());
}
