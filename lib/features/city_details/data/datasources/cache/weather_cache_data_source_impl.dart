import 'dart:convert';

import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

final class WeatherCacheDataSourceImpl implements WeatherCacheDataSource {
  const WeatherCacheDataSourceImpl({required this._localStorage});

  static const _forecastKeyPrefix = 'weather_forecast_v1';
  static const _cacheIndexKey = 'weather_forecast_cache_index_v1';
  static const _maximumCachedCities = 10;

  final LocalStorage _localStorage;

  @override
  Future<void> saveForecast({
    required int cityId,
    required WeatherForecastDto forecast,
  }) async {
    await _localStorage.setString(
      key: _buildForecastKey(cityId),
      value: jsonEncode(forecast.toJson()),
    );

    await _updateCacheIndex(cityId);
  }

  @override
  Future<WeatherForecastDto?> getForecast({required int cityId}) async {
    final cachedJson = await _localStorage.getString(_buildForecastKey(cityId));

    if (cachedJson == null) {
      return null;
    }

    final decodedJson = jsonDecode(cachedJson);

    if (decodedJson is! Map<String, dynamic>) {
      throw const FormatException('Le cache des prévisions est invalide.');
    }

    return WeatherForecastDto.fromJson(decodedJson);
  }

  Future<void> _updateCacheIndex(int cityId) async {
    final cachedCityIds = await _getCachedCityIds();

    cachedCityIds
      ..remove(cityId)
      ..insert(0, cityId);

    final cityIdsToRemove = cachedCityIds.skip(_maximumCachedCities).toList();

    for (final cityIdToRemove in cityIdsToRemove) {
      await _localStorage.remove(_buildForecastKey(cityIdToRemove));
    }

    final retainedCityIds = cachedCityIds.take(_maximumCachedCities).toList();

    await _localStorage.setString(
      key: _cacheIndexKey,
      value: jsonEncode(retainedCityIds),
    );
  }

  Future<List<int>> _getCachedCityIds() async {
    final cachedIndex = await _localStorage.getString(_cacheIndexKey);

    if (cachedIndex == null) {
      return [];
    }

    final decodedIndex = jsonDecode(cachedIndex);

    if (decodedIndex is! List<dynamic>) {
      return [];
    }

    return decodedIndex
        .whereType<num>()
        .map((cityId) => cityId.toInt())
        .toList();
  }

  String _buildForecastKey(int cityId) {
    return '${_forecastKeyPrefix}_$cityId';
  }
}
