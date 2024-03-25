
import 'dart:developer';

class Level{
  final int id;
  final String nomLevel;
  final int rangeMin;
  final int rangeMax;
  final int nbEssais;
  final bool avecFloat;

  Level({
    required this.id,
    required this.nomLevel,
    required this.rangeMin,
    required this.rangeMax,
    required this.nbEssais,
    required this.avecFloat
  });



  Map<String, Object?> toMap() {
    
    // ajouter : 'nbEssais': nbEssais in BD

    
    return {
      'id': id,
      'nomLevel': nomLevel,
      'rangeMin': rangeMin,
      'rangeMax': rangeMax,
      'nbEssais': nbEssais,
      'avecFloat': avecFloat ? 1 : 0,
    };
  }



  factory Level.fromMap(Map<String, dynamic> e) {
    return Level(
      id: e['id'] as int,
      nomLevel: e['nomLevel'] as String,
      rangeMin: e['rangeMin'] as int,
      rangeMax: e['rangeMax'] as int,
      nbEssais: e['nbEssais'] as int,
      avecFloat: e['avecFloat'] == 1,
    );
  }

  
  
  @override
  String toString() {
    return 'Level{id: $id, nomLevel: $nomLevel, rangeMin: $rangeMin, rangeMax: $rangeMax, nbEssais: $nbEssais, avecFloat: $avecFloat}';
  }


}