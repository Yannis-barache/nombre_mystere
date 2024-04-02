import 'dart:math';

class Jeu {
  static int generateNombre(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min) + 1;
  }

  static int compareNombre( nombreMystere, int nombre) {
    if (nombreMystere == nombre) {
      return 0;
    } else if (nombreMystere < nombre) {
      return 1;
    } else {
      return -1;
    }
  }
}
