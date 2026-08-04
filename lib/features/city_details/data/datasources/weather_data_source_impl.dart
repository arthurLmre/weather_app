import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/features/city_details/data/datasources/endpoints/weather_endpoints.dart';
import 'package:weather_app/features/city_details/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

final class WeatherDataSourceImpl implements WeatherDataSource {
  const WeatherDataSourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<WeatherForecastDto> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    final json = await _apiClient.get(
      WeatherEndpoints.forecast,
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'hourly': [
          'weather_code',
          'temperature_2m',
          'apparent_temperature',
          'precipitation_probability',
          'precipitation',
          'wind_speed_10m',
        ].join(','),
        'daily': [
          'weather_code',
          'temperature_2m_min',
          'temperature_2m_max',
          'precipitation_probability_max',
          'precipitation_sum',
          'wind_speed_10m_max',
        ].join(','),
        'forecast_hours': 24,
        'forecast_days': 7,
        'timezone': 'auto',
      },
    );

    return WeatherForecastDto.fromJson(json);
  }
}
