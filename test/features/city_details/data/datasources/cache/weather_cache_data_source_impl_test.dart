import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source_impl.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

final class InMemoryLocalStorage implements LocalStorage {
  final Map<String, String> _strings = {};
  final Map<String, List<String>> _stringLists = {};

  Map<String, String> get strings => Map.unmodifiable(_strings);

  @override
  Future<String?> getString(String key) async => _strings[key];

  @override
  Future<List<String>?> getStringList(String key) async => _stringLists[key];

  @override
  Future<void> setString({required String key, required String value}) async {
    _strings[key] = value;
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> values,
  }) async {
    _stringLists[key] = List.unmodifiable(values);
  }

  @override
  Future<void> remove(String key) async {
    _strings.remove(key);
    _stringLists.remove(key);
  }
}

void main() {
  late InMemoryLocalStorage localStorage;
  late WeatherCacheDataSourceImpl dataSource;

  const forecast = WeatherForecastDto(
    hourly: HourlyWeatherDto(
      dates: ['2026-08-05T12:00'],
      weatherCodes: [0],
      temperatures: [25],
      apparentTemperatures: [26],
      precipitationProbabilities: [10],
      precipitations: [0],
      windSpeeds: [8],
    ),
    daily: DailyForecastDto(
      dates: ['2026-08-05'],
      weatherCodes: [0],
      minTemperatures: [15],
      maxTemperatures: [27],
      precipitationProbabilities: [10],
      precipitations: [0],
      maxWindSpeeds: [15],
    ),
  );

  setUp(() {
    localStorage = InMemoryLocalStorage();

    dataSource = WeatherCacheDataSourceImpl(localStorage: localStorage);
  });

  group('WeatherCacheDataSourceImpl', () {
    test('sauvegarde puis restitue les prévisions d’une ville', () async {
      const cityId = 2996944;

      await dataSource.saveForecast(cityId: cityId, forecast: forecast);

      final result = await dataSource.getForecast(cityId: cityId);

      expect(result, forecast);
    });

    test('conserve uniquement les dix dernières villes', () async {
      for (var cityId = 1; cityId <= 11; cityId++) {
        await dataSource.saveForecast(cityId: cityId, forecast: forecast);
      }

      expect(await dataSource.getForecast(cityId: 1), isNull);

      for (var cityId = 2; cityId <= 11; cityId++) {
        expect(
          await dataSource.getForecast(cityId: cityId),
          forecast,
          reason: 'La ville $cityId doit encore être présente dans le cache.',
        );
      }
    });

    test(
      'moves an existing city to the front without increasing cache size',
      () async {
        for (var cityId = 1; cityId <= 10; cityId++) {
          await dataSource.saveForecast(cityId: cityId, forecast: forecast);
        }

        await dataSource.saveForecast(cityId: 5, forecast: forecast);

        final cachedForecastKeys = localStorage.strings.keys
            .where((key) => key.startsWith('weather_forecast_v1_'))
            .toList();

        expect(cachedForecastKeys, hasLength(10));

        final cachedIndexJson =
            localStorage.strings['weather_forecast_cache_index_v1'];

        expect(cachedIndexJson, isNotNull);

        final cachedCityIds = (jsonDecode(cachedIndexJson!) as List<dynamic>)
            .whereType<num>()
            .map((cityId) => cityId.toInt());

        expect(cachedCityIds, [5, 10, 9, 8, 7, 6, 4, 3, 2, 1]);

        expect(cachedCityIds.toSet(), hasLength(10));
      },
    );
  });
}
