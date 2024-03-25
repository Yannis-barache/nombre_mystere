import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
  import 'package:nombre_mystere/pages/HomePage.dart';
import 'package:nombre_mystere/pages/RulesPage.dart';
import 'package:nombre_mystere/pages/PageGame.dart';

import 'package:nombre_mystere/pages/LevelPage.dart';
import 'package:nombre_mystere/pages/GamePage.dart';
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
          GoRoute(path: 'jeu', parentNavigatorKey: _goRouterKey, builder: (context, state) {
            return const PageGame(max: 100, min: 0, nombreMystere: 34, essaisMax: 10);
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
            // page de jeu avec l'id du niveau
            path: 'game/:id',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return GamePage(idNiveau: int.parse(state.pathParameters['id']!));
            },
          ),
          GoRoute(
            path: 'score/:id',
            parentNavigatorKey: _goRouterKey,
            builder: (context, state) {
              return const ScorePage();
            },
          ),
          
        ],
      ),
    ],
  );
}