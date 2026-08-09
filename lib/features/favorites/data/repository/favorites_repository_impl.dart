import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/datasources/favorites_data_source.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository.dart';

final class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({required this._localDataSource});

  final FavoritesLocalDataSource _localDataSource;

  @override
  Future<List<City>> getFavorites() {
    return _localDataSource.getFavorites();
  }

  @override
  Future<void> addFavorite(City city) async {
    final favorites = await getFavorites();

    final alreadyExists = favorites.any((favorite) => favorite.id == city.id);

    if (alreadyExists) {
      return;
    }

    await _localDataSource.saveFavorites([...favorites, city]);
  }

  @override
  Future<void> removeFavorite(City city) async {
    final favorites = await getFavorites();

    final updatedFavorites = favorites
        .where((favorite) => favorite.id != city.id)
        .toList(growable: false);

    await _localDataSource.saveFavorites(updatedFavorites);
  }

  @override
  Future<void> toggleFavorite(City city) async {
    final favorites = await getFavorites();

    final isFavorite = favorites.any((favorite) => favorite.id == city.id);

    if (isFavorite) {
      final updatedFavorites = favorites
          .where((favorite) => favorite.id != city.id)
          .toList(growable: false);

      await _localDataSource.saveFavorites(updatedFavorites);
      return;
    }

    await _localDataSource.saveFavorites([...favorites, city]);
  }
}
