import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';

abstract interface class WeatherRepository {
  Future<WeatherForecast> getForecast({
    required double latitude,
    required double longitude,
  });
}
