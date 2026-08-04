import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/router/app_routes.dart';
import 'package:weather_app/features/city_details/ui/page/city_details_page.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/page/city_search_page.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.citySearch,
    routes: [
      GoRoute(
        path: AppRoutes.citySearch,
        builder: (context, state) => const CitySearchPage(),
      ),
      GoRoute(
        path: AppRoutes.cityDetails,
        builder: (context, state) {
          final city = state.extra;

          if (city is! City) {
            return const Scaffold(
              body: Center(child: Text('Ville introuvable')),
            );
          }

          return CityDetailsPage(city: city);
        },
      ),
    ],
  );
}
