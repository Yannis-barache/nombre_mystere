import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/model/Jeu.dart';
import 'package:flutter/services.dart';

class PageGame extends StatefulWidget {

  final int max;
  final int min;
  final int nombreMystere;
  final int essaisMax;


  const PageGame({
    Key? key,
    required this.max,
    required this.min,
    required this.nombreMystere,
    required this.essaisMax,
  }) : super(key: key);

  @override
  _PageGameState createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {

  final TextEditingController _controller = TextEditingController();
  int essais = 0;
  int? min;
  int? max;

  @override
  void initState() {
    super.initState();
    min = widget.min;
    max = widget.max;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nombre mystère : ${widget.nombreMystere}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(min.toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Entrez un nombre',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(max.toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _onPressed,
                child: const Text('Valider'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Essais : ${essais}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
  final String nombreStr = _controller.text;
  debugPrint('Nombre : $nombreStr');
  if (nombreStr.isEmpty || int.tryParse(nombreStr) == null) {
    debugPrint('Invalid number');
    return;
  }
  final int nombre = int.parse(nombreStr);
  final int resultat = Jeu.compareNombre(widget.nombreMystere, nombre);
  if (resultat == 0) {
    debugPrint('Gagné');
  } else {
    setState(() {
      essais = essais + 1;
      if (resultat == 1) {
        max = nombre;
      } else {
        min = nombre;
      }
    });
    if (essais == widget.essaisMax) {
      context.go('/lose');
    }
  }
  }
}