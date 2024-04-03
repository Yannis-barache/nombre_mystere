# TP Note nombre mystère

## Présentation

Ce projet est un TP noté dans la matière Développement Mobile.
Nous devons réaliser un petit jeu mobile et dans notre cas un jeu de nombre mystère.

## Les règles du jeu

Le jeu consiste à trouver un nombre mystère compris entre deux bornes qui vont être définis par le 
niveau de difficulté choisi par le joueur.
A chaque essai, le jeu va mettre à jour les bornes qui sont affichés sur l'écran

### Exemple

Si le nombre mystère est `34` et que les bornes sont `1` et `100` et que le joueur propose `50`,
le jeu va mettre à jour le 100 pour réduire l'intervalle de recherche.

## Niveaux de difficulté



## Technologies utilisées

[![Les technologies](https://skillicons.dev/icons?i=dart,flutter,androidstudio,)](https://skillicons.dev)

## Membres du groupe

[![Yannis Barache](https://img.shields.io/badge/Yannis%20Barache-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Yannis-barache)
[![Abdoulahi Fofana](https://img.shields.io/badge/Abdoulahi%20Fofana-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Abdwuu)

## Fonctionnalités

- [x] Le jeu doit générer un nombre mystère aléatoire
- [x] Le joueur doit pouvoir proposer un nombre
- [x] Le jeu doit indiquer si le nombre mystère est plus grand ou plus petit que le nombre proposé
- [x] Le joueur doit avoir 10 essais pour trouver le nombre mystère
- [x] Le joueur doit pouvoir recommencer une partie
- [x] Le joueur doit pouvoir changer la difficulté du jeu
- [x] Le jeu doit pouvoir enrengistrer le score d'un joueur