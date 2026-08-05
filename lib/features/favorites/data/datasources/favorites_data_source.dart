import 'package:weather_app/features/city_search/data/entities/city.dart';

abstract interface class FavoritesLocalDataSource {
  Future<List<City>> getFavorites();

  Future<void> saveFavorites(List<City> favorites);
}
