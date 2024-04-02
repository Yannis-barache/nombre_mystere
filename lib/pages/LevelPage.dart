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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List>(
          future: levels,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.expand((e) => [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/jeu/${e.id}');
                    },
                    child: Text(e.nomLevel),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    )

                  ),
                  const SizedBox(height: 20),
                ]).toList(),
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
 
