import 'package:dio/dio.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';

final class CitySearchRepositoryImpl implements CitySearchRepository {
  CitySearchRepositoryImpl({
    required this._citySearchDataSource,
    required this._historyLocalDataSource,
  });

  final CitySearchDataSource _citySearchDataSource;
  final SearchHistoryLocalDataSource _historyLocalDataSource;

  @override
  Future<List<City>> getSearchHistory() {
    return _historyLocalDataSource.getHistory();
  }

  @override
  Future<void> addCityToHistory(City city) {
    return _historyLocalDataSource.addCity(city);
  }

  @override
  Future<void> removeCityFromHistory(City city) {
    return _historyLocalDataSource.removeCity(city);
  }

  @override
  Future<void> clearSearchHistory() {
    return _historyLocalDataSource.clearHistory();
  }

  @override
  Future<List<City>> searchCities(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final cityDtos = await _citySearchDataSource.searchCities(
      query,
      cancelToken: cancelToken,
    );

    return cityDtos.map((dto) => dto.toDomain()).toList();
  }
}
