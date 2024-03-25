import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  Future<List>? levels;
  final LevelBD levelBD = LevelBD();


  @override
  void initState() {
    super.initState();


    fetchLevels();
  }

  void fetchLevels() {
    setState(() {
      levels = levelBD.getLevels();
    });

    levels!.then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                levelBD.showColumns();
                levelBD.insertLevel();
                fetchLevels();
              },
              child: const Text('Refresh'),
            ),
            FutureBuilder<List>(
              future: levels,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: // les boutonn avec le nom des levels et renvoie à la page jeu avec l'id du level
                      snapshot.data!.map((e) => ElevatedButton(
                        onPressed: () {
                          context.go('/jeu/${e.id}');
                        },
                        child: Text(e.nomLevel),
                      )).toList(), 
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      
    );
  }
}
 
