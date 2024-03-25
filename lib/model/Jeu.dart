import 'dart:math';

class Jeu {
  static int generateNombre(int max) {
    final Random random = Random();
    return random.nextInt(max);
  }

  static int compareNombre(int nombreMystere, int nombre) {
    if (nombreMystere == nombre) {
      return 0;
    } else if (nombreMystere < nombre) {
      return 1;
    } else {
      return -1;
    }
  }
}
