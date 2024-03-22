import 'package:flutter/material.dart';


class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scores'),
      ),
      body: Center(
        child: Text('Scores'),
      ),
    );
  }
}
