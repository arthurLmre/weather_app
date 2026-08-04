import 'package:weather_app/features/city_search/data/models/city_dto.dart';

abstract interface class CitySearchDataSource {
  Future<List<CityDto>> searchCities(String query);
}
