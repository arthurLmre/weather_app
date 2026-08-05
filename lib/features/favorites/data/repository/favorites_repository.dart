import 'package:weather_app/features/city_search/data/entities/city.dart';

abstract interface class FavoritesRepository {
  Future<List<City>> getFavorites();

  Future<void> addFavorite(City city);

  Future<void> removeFavorite(City city);

  Future<void> toggleFavorite(City city);
}
