import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

abstract interface class WeatherDataSource {
  Future<WeatherForecastDto> getForecast({
    required double latitude,
    required double longitude,
  });
}
