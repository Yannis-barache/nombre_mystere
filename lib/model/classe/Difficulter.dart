
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

  factory Level.fromSqfliteDatabase(Map<String, dynamic> data){
    return Level(
      id: data['idDifficulte']?.toInt() ?? 0,
      nomLevel: data['nomDifficulte'] ?? '',
      rangeMin: data['rangeMin']?.toInt() ?? 0,
      rangeMax: data['rangeMax']?.toInt() ?? 5,
      nbEssais: data['nbEssais']?.toInt() ?? 2,
      avecFloat: data['avecFloat']?.toBool() ?? false
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'idDifficulte': id,
      'nomDifficulte': nomLevel,
      'rangeMin': rangeMin,
      'rangeMax': rangeMax,
      'nbEssais': nbEssais,
      'avecFloat': avecFloat
    };
  }

}