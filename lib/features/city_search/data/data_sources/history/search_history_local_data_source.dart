import 'package:weather_app/features/city_search/data/entities/city.dart';

abstract interface class SearchHistoryLocalDataSource {
  Future<List<City>> getHistory();

  Future<void> addCity(City city);

  Future<void> removeCity(City city);

  Future<void> clearHistory();
}
