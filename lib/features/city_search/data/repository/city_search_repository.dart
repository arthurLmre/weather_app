import 'package:dio/dio.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

abstract interface class CitySearchRepository {
  Future<List<City>> searchCities(String query, {CancelToken? cancelToken});

  Future<List<City>> getSearchHistory();

  Future<void> addCityToHistory(City city);

  Future<void> removeCityFromHistory(City city);

  Future<void> clearSearchHistory();
}
