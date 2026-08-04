import 'package:weather_app/features/city_search/data/entities/city.dart';

abstract interface class CitySearchRepository {
  Future<List<City>> searchCities(String query);
}
