class Score{
  int idScore;
  int idLevel;
  int idUser;
  int nbEssai;

  Score({
    required this.idScore,
    required this.idLevel,
    required this.idUser,
    required this.nbEssai,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      idScore: json['idScore'],
      idLevel: json['idLevel'],
      idUser: json['idUser'],
      nbEssai: json['nbEssai'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'idScore': idScore,
      'idLevel': idLevel,
      'idUser': idUser,
      'nbEssai': nbEssai,
    };
  }

  @override
  String toString() {
    return 'Score{idScore: $idScore, idLevel: $idLevel, idUser: $idUser, nbEssai: $nbEssai}';
  }

}