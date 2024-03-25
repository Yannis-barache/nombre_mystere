// classe joueur.dart

class Joueur{
  int id = -1;
  String pseudo;

  Joueur({
    required this.pseudo
     });

  Joueur.withId({
      required this.id,
      required this.pseudo
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
    );
  }

  @override
  String toString() {
    return 'Joueur{id: $id, pseudo: $pseudo}';
  }

}