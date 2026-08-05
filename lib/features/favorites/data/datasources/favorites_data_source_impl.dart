import 'dart:convert';

import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/datasources/favorites_data_source.dart';

final class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  FavoritesLocalDataSourceImpl({required this._localStorage});

  static const _favoritesKey = 'favorite_cities';

  final LocalStorage _localStorage;

  @override
  Future<List<City>> getFavorites() async {
    final encodedFavorites =
        await _localStorage.getStringList(_favoritesKey) ?? [];

    final favorites = <City>[];

    for (final encodedCity in encodedFavorites) {
      try {
        final json = jsonDecode(encodedCity) as Map<String, dynamic>;

        favorites.add(City.fromJson(json));
      } on FormatException {
        // Ignore une entrée JSON invalide.
      } on TypeError {
        // Ignore une entrée dont la structure est invalide.
      }
    }

    return favorites;
  }

  @override
  Future<void> saveFavorites(List<City> favorites) async {
    final encodedFavorites = favorites
        .map((city) => jsonEncode(city.toJson()))
        .toList(growable: false);

    await _localStorage.setStringList(
      key: _favoritesKey,
      values: encodedFavorites,
    );
  }
}
