import 'dart:ffi';

class Level{
  final int id;
  final String nomLevel;
  final int rangeMin;
  final int rangeMax;
  final int nbEssais;
  final Bool avecFloat;

  Level({
    required this.id,
    required this.nomLevel,
    required this.rangeMin,
    required this.rangeMax,
    required this.nbEssais,
    required this.avecFloat
  });

  factory Level.fromSqfliteDatabase(Map<String, dynamic> data){
    return Level(
      id: data['id']?.toInt() ?? 0,
      nomLevel: data['nomLevel'] ?? '',
      rangeMin: data['rangeMin']?.toInt() ?? 0,
      rangeMax: data['rangeMax']?.toInt() ?? 5,
      nbEssais: data['nbEssais']?.toInt() ?? 2,
      avecFloat: data['avecFloat']?.toBool() ?? false
    );
  }

}