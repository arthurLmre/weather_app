import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/models/city_dto.dart';

final class SearchHistoryLocalDataSourceImpl
    implements SearchHistoryLocalDataSource {
  SearchHistoryLocalDataSourceImpl(this._preferences);

  static const _historyKey = 'city_search_history';
  static const _maximumHistoryLength = 10;

  final SharedPreferences _preferences;

  @override
  Future<List<City>> getHistory() async {
    final encodedHistory = _preferences.getStringList(_historyKey) ?? [];

    final cities = <City>[];

    for (final encodedCity in encodedHistory) {
      try {
        final json = jsonDecode(encodedCity) as Map<String, dynamic>;
        cities.add(CityDto.fromJson(json).toDomain());
      } on FormatException {
        // Ignore une entrée JSON invalide.
      } on TypeError {
        // Ignore une entrée dont la structure est invalide.
      }
    }

    return cities;
  }

  @override
  Future<void> addCity(City city) async {
    final history = await getHistory();

    history.removeWhere((savedCity) => savedCity.id == city.id);

    history.insert(0, city);

    final limitedHistory = history.take(_maximumHistoryLength);

    final encodedHistory = limitedHistory.map((savedCity) {
      final dto = CityDto.fromDomain(savedCity);

      return jsonEncode(dto.toJson());
    }).toList();

    await _preferences.setStringList(_historyKey, encodedHistory);
  }

  @override
  Future<void> removeCity(City city) async {
    final history = await getHistory();

    history.removeWhere((savedCity) => savedCity.id == city.id);

    final encodedHistory = history.map((savedCity) {
      final dto = CityDto.fromDomain(savedCity);

      return jsonEncode(dto.toJson());
    }).toList();

    await _preferences.setStringList(_historyKey, encodedHistory);
  }

  @override
  Future<void> clearHistory() {
    return _preferences.remove(_historyKey);
  }
}
