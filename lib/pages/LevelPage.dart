import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/model/classe/Difficulter.dart';
import 'package:nombre_mystere/model/sql/bd.dart';


class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => LevelPageState();
}

class LevelPageState extends State<LevelPage> {
  Future<List<Level>>? futureLevel;



@override
void initState() {
  super.initState();
  // Ne pas appeler fetchLevel() ici, car FutureBuilder le gère déjà
  futureLevel = BD.fetchAllLevel();
}
    
  void fetchLevel() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Niveau'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: ()=> {
                futureLevel?.then((value) => {
                  for (var level in value) {
                    log(level.nomLevel)
                  }
                })
              },
              child: const Text('Charger les niveaux'),
            ),
            FutureBuilder<List<Level>>(
                        future: futureLevel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final levels = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: levels.length,
                              itemBuilder: (context, index) {
                                final level = levels[index];
                                return ListTile(
                                  title: Text(level.nomLevel),
                                  // Add any other properties you want to display
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
          ],
        ),
      ),
    );
  }
}