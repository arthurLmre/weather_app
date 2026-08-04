import 'package:go_router/go_router.dart';
import 'package:weather_app/core/router/app_routes.dart';
import 'package:weather_app/features/city_search/ui/city_search_page.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.citySearch,
    routes: [
      GoRoute(
        path: AppRoutes.citySearch,
        builder: (context, state) => const CitySearchPage(),
      ),
    ],
  );
}
