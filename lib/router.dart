import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/screens/images_screen.dart';
import 'package:my_flutter_6/features/state/expenses_container.dart';

import 'features/screens/CategoriesScreen.dart';
import 'features/screens/StatisticsScreen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const ExpensesContainer();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'images',
            builder: (BuildContext context, GoRouterState state) {
              return const ImagesScreen();
            },
          ),
          GoRoute(
            path: 'statistics',
            builder: (BuildContext context, GoRouterState state) {
              return StatisticsScreen(expenses: []);
            },
          ),
          GoRoute(
            path: 'categories',
            builder: (BuildContext context, GoRouterState state) {
              return const CategoriesScreen();
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}