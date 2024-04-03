import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/const.dart';
import 'package:nombre_mystere/model/classeBD/Level_BD.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  String? message;
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

  void goTolevel(int nbLevel) {
    if (nbLevel <= leJoueur.currLevel) {
      context.go('/jeu/$nbLevel');
    }else{
      setState(() {
        message = 'Vous devez finir le niveau ${leJoueur.currLevel} pour accéder à ce niveau';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Niveaux du joueur" +leJoueur.currLevel.toString());
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
                    children: snapshot.data!.map((e) {
                      bool isAccessible = e.id <= leJoueur.currLevel;
                      return ElevatedButton(
                        onPressed: isAccessible ? () {
                          log('Level: ${e.id} > ${leJoueur.currLevel}  :  ${e.id < leJoueur.currLevel ? 'true' : 'false'}');
                          goTolevel(e.id);
                        } : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            isAccessible ? Colors.green : const Color(0xD58690),
                          ),
                        ),
                        child: Text(e.nomLevel),
                      );
                    }).toList(),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        message!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      
    );
  }
}
 
