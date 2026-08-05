import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

abstract interface class WeatherCacheDataSource {
  Future<void> saveForecast({
    required int cityId,
    required WeatherForecastDto forecast,
  });

  Future<WeatherForecastDto?> getForecast({required int cityId});
}
