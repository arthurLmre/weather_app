import 'package:weather_app/features/city_details/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';

final class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({required this._weatherDataSource});

  final WeatherDataSource _weatherDataSource;

  @override
  Future<WeatherForecast> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    final dto = await _weatherDataSource.getForecast(
      latitude: latitude,
      longitude: longitude,
    );

    return dto.toEntity();
  }
}
