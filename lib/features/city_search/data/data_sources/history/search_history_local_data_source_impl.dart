import 'dart:convert';

import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

final class SearchHistoryLocalDataSourceImpl
    implements SearchHistoryLocalDataSource {
  SearchHistoryLocalDataSourceImpl(this._localStorage);

  static const _historyKey = 'city_search_history';
  static const _maximumHistoryLength = 10;

  final LocalStorage _localStorage;

  @override
  Future<List<City>> getHistory() async {
    final encodedHistory = await _localStorage.getStringList(_historyKey) ?? [];

    final cities = <City>[];

    for (final encodedCity in encodedHistory) {
      try {
        final json = jsonDecode(encodedCity) as Map<String, dynamic>;

        cities.add(City.fromJson(json));
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

    final encodedHistory = history
        .take(_maximumHistoryLength)
        .map((savedCity) => jsonEncode(savedCity.toJson()))
        .toList();

    await _localStorage.setStringList(key: _historyKey, values: encodedHistory);
  }

  @override
  Future<void> removeCity(City city) async {
    final history = await getHistory();

    history.removeWhere((savedCity) => savedCity.id == city.id);

    final encodedHistory = history
        .map((savedCity) => jsonEncode(savedCity.toJson()))
        .toList();

    await _localStorage.setStringList(key: _historyKey, values: encodedHistory);
  }

  @override
  Future<void> clearHistory() {
    return _localStorage.remove(_historyKey);
  }
}
