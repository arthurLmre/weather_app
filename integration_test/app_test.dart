import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source_impl.dart';
import 'package:weather_app/features/city_details/data/datasources/remote/weather_data_source.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/city_details/data/service/activity_repository.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';
import 'package:weather_app/features/city_search/ui/page/components/city_card.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';
import 'package:weather_app/main.dart';

const _lyon = City(
  id: 2996944,
  name: 'Lyon',
  latitude: 45.7485,
  longitude: 4.8467,
  country: 'France',
  region: 'Auvergne-Rhône-Alpes',
);

const _forecastDto = WeatherForecastDto(
  hourly: HourlyWeatherDto(
    dates: [
      '2026-08-05T09:00',
      '2026-08-05T10:00',
      '2026-08-05T11:00',
      '2026-08-05T12:00',
      '2026-08-05T13:00',
      '2026-08-05T14:00',
      '2026-08-05T15:00',
      '2026-08-05T16:00',
    ],
    weatherCodes: [1, 1, 2, 2, 3, 61, 61, 2],
    temperatures: [18, 19.5, 21, 22.5, 24, 23, 22, 21],
    apparentTemperatures: [18, 20, 21.5, 23, 24.5, 23, 21.5, 20.5],
    precipitationProbabilities: [5, 5, 10, 15, 20, 45, 60, 30],
    precipitations: [0, 0, 0, 0, 0, 0.4, 1.2, 0.2],
    windSpeeds: [6, 7, 8, 9, 11, 14, 16, 12],
  ),
  daily: DailyForecastDto(
    dates: [
      '2026-08-05',
      '2026-08-06',
      '2026-08-07',
      '2026-08-08',
      '2026-08-09',
      '2026-08-10',
      '2026-08-11',
    ],
    weatherCodes: [2, 61, 3, 1, 0, 2, 80],
    minTemperatures: [15, 14, 13, 16, 17, 16, 15],
    maxTemperatures: [24, 21, 22, 27, 29, 26, 23],
    precipitationProbabilities: [20, 70, 35, 10, 5, 20, 60],
    precipitations: [0.2, 6.5, 0.8, 0, 0, 0.3, 4.2],
    maxWindSpeeds: [16, 24, 18, 12, 10, 14, 22],
  ),
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'recherche une ville, ouvre les prévisions et l’ajoute aux recherches récentes',
    (tester) async {
      final citySearchRepository = InMemoryCitySearchRepository(
        searchResults: const [_lyon],
      );

      await _pumpApplication(
        tester,
        citySearchRepository: citySearchRepository,
        weatherRepository: StaticWeatherRepository(),
        favoritesRepository: InMemoryFavoritesRepository(),
      );

      await _searchAndOpenLyon(tester);

      expect(find.text('Prochaines 24 heures'), findsOneWidget);
      expect(find.text('Prévisions sur 7 jours'), findsOneWidget);
      await _pause(tester);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await _pause(tester);

      await tester.tap(find.byKey(const Key('clear-search-button')));
      await tester.pumpAndSettle();
      await _pause(tester);

      expect(find.text('Recherches récentes'), findsOneWidget);
      expect(find.text('Lyon'), findsOneWidget);
      expect(citySearchRepository.history, [_lyon]);
    },
  );

  testWidgets(
    'ajoute une ville aux favoris puis l’affiche dans l’onglet Favoris',
    (tester) async {
      final favoritesRepository = InMemoryFavoritesRepository();

      await _pumpApplication(
        tester,
        citySearchRepository: InMemoryCitySearchRepository(
          searchResults: const [_lyon],
        ),
        weatherRepository: StaticWeatherRepository(),
        favoritesRepository: favoritesRepository,
      );

      await _searchAndOpenLyon(tester);

      await tester.tap(find.byTooltip('Ajouter aux favoris'));
      await tester.pumpAndSettle();
      await _pause(tester);

      expect(find.byTooltip('Retirer des favoris'), findsOneWidget);
      expect(favoritesRepository.favorites, [_lyon]);
      await _pause(tester);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await _pause(tester);

      await tester.tap(find.text('Favoris'));
      await tester.pumpAndSettle();
      await _pause(tester);

      expect(find.text('Mes favoris'), findsOneWidget);
      expect(find.text('Lyon'), findsOneWidget);
    },
  );

  testWidgets(
    'affiche les prévisions mises en cache lorsque le réseau échoue',
    (tester) async {
      final localStorage = InMemoryLocalStorage();
      final cacheDataSource = WeatherCacheDataSourceImpl(
        localStorage: localStorage,
      );

      await cacheDataSource.saveForecast(
        cityId: _lyon.id,
        forecast: _forecastDto,
      );

      final weatherRepository = WeatherRepositoryImpl(
        weatherDataSource: FailingWeatherDataSource(),
        cacheDataSource: cacheDataSource,
      );

      await _pumpApplication(
        tester,
        citySearchRepository: InMemoryCitySearchRepository(
          searchResults: const [_lyon],
        ),
        weatherRepository: weatherRepository,
        favoritesRepository: InMemoryFavoritesRepository(),
      );

      await _searchAndOpenLyon(tester);
      await _pause(tester);

      expect(find.text('Prochaines 24 heures'), findsOneWidget);
      expect(find.text('Prévisions sur 7 jours'), findsOneWidget);
      expect(
        find.text('Impossible de récupérer les prévisions météo.'),
        findsNothing,
      );
    },
  );
}

Future<void> _pumpApplication(
  WidgetTester tester, {
  required CitySearchRepository citySearchRepository,
  required WeatherRepository weatherRepository,
  required FavoritesRepository favoritesRepository,
}) async {
  AppRouter.router.go('/search');

  await tester.pumpWidget(
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
          value: const ActivityRecommendationServiceImpl(),
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

  await tester.pumpAndSettle();
}

Future<void> _searchAndOpenLyon(WidgetTester tester) async {
  final searchField = find.byType(TextField);

  expect(searchField, findsOneWidget);

  await tester.enterText(searchField, 'Lyon');
  await tester.pumpAndSettle();

  final lyonResult = find.widgetWithText(CityCard, 'Lyon');

  expect(lyonResult, findsOneWidget);

  await tester.tap(lyonResult);
  await tester.pumpAndSettle();
}

Future<void> _pause(
  WidgetTester tester, [
  Duration duration = const Duration(milliseconds: 500),
]) async {
  await tester.pump(duration);
}

final class InMemoryCitySearchRepository implements CitySearchRepository {
  InMemoryCitySearchRepository({required this.searchResults});

  final List<City> searchResults;
  final List<City> history = [];

  @override
  Future<List<City>> searchCities(
    String query, {
    CancelToken? cancelToken,
  }) async {
    if (query.trim().isEmpty) {
      return [];
    }

    return searchResults;
  }

  @override
  Future<List<City>> getSearchHistory() async => List.unmodifiable(history);

  @override
  Future<void> addCityToHistory(City city) async {
    history
      ..removeWhere((savedCity) => savedCity.id == city.id)
      ..insert(0, city);

    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
  }

  @override
  Future<void> removeCityFromHistory(City city) async {
    history.removeWhere((savedCity) => savedCity.id == city.id);
  }

  @override
  Future<void> clearSearchHistory() async {
    history.clear();
  }
}

final class StaticWeatherRepository implements WeatherRepository {
  @override
  Future<WeatherForecast> getForecast({
    required int cityId,
    required double latitude,
    required double longitude,
  }) async {
    return _forecastDto.toEntity();
  }
}

final class FailingWeatherDataSource implements WeatherDataSource {
  @override
  Future<WeatherForecastDto> getForecast({
    required double latitude,
    required double longitude,
  }) {
    throw Exception('Network unavailable');
  }
}

final class InMemoryFavoritesRepository implements FavoritesRepository {
  final List<City> favorites = [];

  @override
  Future<List<City>> getFavorites() async => List.unmodifiable(favorites);

  @override
  Future<void> addFavorite(City city) async {
    if (favorites.every((favorite) => favorite.id != city.id)) {
      favorites.add(city);
    }
  }

  @override
  Future<void> removeFavorite(City city) async {
    favorites.removeWhere((favorite) => favorite.id == city.id);
  }

  @override
  Future<void> toggleFavorite(City city) async {
    final isFavorite = favorites.any((favorite) => favorite.id == city.id);

    if (isFavorite) {
      await removeFavorite(city);
    } else {
      await addFavorite(city);
    }
  }
}

final class InMemoryLocalStorage implements LocalStorage {
  final Map<String, String> _strings = {};
  final Map<String, List<String>> _stringLists = {};

  @override
  Future<String?> getString(String key) async => _strings[key];

  @override
  Future<List<String>?> getStringList(String key) async {
    final value = _stringLists[key];
    return value == null ? null : List.unmodifiable(value);
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    _strings[key] = value;
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> values,
  }) async {
    _stringLists[key] = List.of(values);
  }

  @override
  Future<void> remove(String key) async {
    _strings.remove(key);
    _stringLists.remove(key);
  }
}
