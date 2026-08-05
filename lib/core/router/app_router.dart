import 'package:go_router/go_router.dart';
import 'package:weather_app/core/router/main_navigation_page.dart';
import 'package:weather_app/features/city_details/ui/page/city_details_page.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/page/city_search_page.dart';
import 'package:weather_app/features/favorites/ui/page/favorites_page.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: '/search',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: 'search',
                builder: (context, state) {
                  return const CitySearchPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                name: 'favorites',
                builder: (context, state) {
                  return const FavoritesPage();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/city-details',
        name: 'cityDetails',
        builder: (context, state) {
          final city = state.extra! as City;

          return CityDetailsPage(city: city);
        },
      ),
    ],
  );
}
