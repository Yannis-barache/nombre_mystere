import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/model/classe/level.dart';
import 'package:nombre_mystere/pages/HomePage.dart';
import 'package:nombre_mystere/pages/RulesPage.dart';
import 'package:nombre_mystere/pages/PageGame.dart';
import 'package:nombre_mystere/pages/GameOver.dart';
import 'package:nombre_mystere/pages/LevelPage.dart';
import 'package:nombre_mystere/pages/LoginPage.dart';
import 'package:nombre_mystere/pages/ScorePage.dart';

final GlobalKey<NavigatorState> _goRouterKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellRouteKey = GlobalKey<NavigatorState>();

class AppRouter { 

  get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    navigatorKey: _goRouterKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return  const HomePage();
        },
        routes: [
          GoRoute(
            path: 'regles',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return const RulesPage();
            },
          ),
          GoRoute(path: 'jeu/:id', parentNavigatorKey: _goRouterKey, builder: (context, state) {
            final int niveauLevel = int.parse(state.pathParameters['id']!) ;
            return PageGame(idNiveau: niveauLevel);
          }),
          GoRoute(
            // page de jeu avec l'id du niveau
            path: 'login',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'niveaux',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return const LevelPage();
            },
          ),
          GoRoute(
            path: 'score/:id',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return const ScorePage();
            },
          ),
          GoRoute(
            path: 'gameover/:idNiv/:result/:nbEssais',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              final int idNiv = int.parse(state.pathParameters['idNiv']!);
              final String result = state.pathParameters['result']!;
              final int nbEssais = int.parse(state.pathParameters['nbEssais']!);
              return GameOver(result: result,nbEssais: nbEssais, idNiveau: idNiv);
            },
          ),
        ],
      ),
    ],
  );
}