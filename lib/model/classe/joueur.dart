class Joueur {
  int id = -1;
  String pseudo;
  int currLevel = 1;

  Joueur({
    required this.pseudo,
  });

  Joueur.withId({
    required this.id,
    required this.pseudo,
    required this.currLevel,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
    };
  }

  factory Joueur.fromMap(Map<String, dynamic> e) {
    return Joueur.withId(
      id: e['id'] as int,
      pseudo: e['pseudo'] as String,
      currLevel: e['currentLevel'] as int,
    );
  }

  @override
  String toString() {
    return 'Joueur{id: $id, pseudo: $pseudo, currentLevel: $currLevel}';
  }

  // Fonction pour rechercher un joueur par son ID
  static Joueur firstWhere(List<Joueur> joueurs, int id) {
    return joueurs.firstWhere((joueur) => joueur.id == id, orElse: () => Joueur(pseudo: 'JoueurX'));
  }
}
