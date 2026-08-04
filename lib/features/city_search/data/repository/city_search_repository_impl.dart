import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';

final class CitySearchRepositoryImpl implements CitySearchRepository {
  const CitySearchRepositoryImpl({required this._dataSource});

  final CitySearchDataSource _dataSource;

  @override
  Future<List<City>> searchCities(String query) async {
    final cityDtos = await _dataSource.searchCities(query);

    return cityDtos
        .map((cityDto) => cityDto.toDomain())
        .toList(growable: false);
  }
}
