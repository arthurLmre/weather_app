import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/network/dio_api_client.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/core/storage/shared_preferences_local_storage.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source_impl.dart';
import 'package:weather_app/features/city_details/data/datasources/remote/weather_data_source_impl.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/city_details/data/service/activity_repository.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository_impl.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';
import 'package:weather_app/features/favorites/data/datasources/favorites_data_source_impl.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = DioApiClient();
  final sharedPreferences = SharedPreferencesAsync();
  final localStorage = SharedPreferencesLocalStorage(sharedPreferences);

  final citySearchRepository = CitySearchRepositoryImpl(
    citySearchDataSource: CitySearchDataSourceImpl(apiClient: apiClient),
    historyLocalDataSource: SearchHistoryLocalDataSourceImpl(localStorage),
  );
  final weatherRepository = WeatherRepositoryImpl(
    weatherDataSource: WeatherDataSourceImpl(apiClient: apiClient),
    cacheDataSource: WeatherCacheDataSourceImpl(localStorage: localStorage),
  );
  final favoritesRepository = FavoritesRepositoryImpl(
    localDataSource: FavoritesLocalDataSourceImpl(localStorage: localStorage),
  );
  final activityRecommendationService = ActivityRecommendationServiceImpl();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CitySearchRepository>.value(
          value: citySearchRepository,
        ),
        RepositoryProvider<WeatherRepository>.value(value: weatherRepository),
        RepositoryProvider<FavoritesRepository>.value(
          value: favoritesRepository,
        ),
        RepositoryProvider<ActivityRecommendationService>.value(
          value: activityRecommendationService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CitySearchCubit(
              repository: context.read<CitySearchRepository>(),
            )..loadHistory(),
          ),
          BlocProvider(
            create: (context) => CityDetailsCubit(
              weatherRepository: context.read<WeatherRepository>(),
              recommendationService: context
                  .read<ActivityRecommendationService>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                FavoritesCubit(repository: context.read<FavoritesRepository>())
                  ..loadFavorites(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
