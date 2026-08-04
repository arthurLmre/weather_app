import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';

part 'weather_forecast_dto.freezed.dart';
part 'weather_forecast_dto.g.dart';

@freezed
abstract class WeatherForecastDto with _$WeatherForecastDto {
  const WeatherForecastDto._();

  const factory WeatherForecastDto({
    required HourlyWeatherDto hourly,
    required DailyForecastDto daily,
  }) = _WeatherForecastDto;

  factory WeatherForecastDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDtoFromJson(json);

  WeatherForecast toEntity() {
    return WeatherForecast(
      hours: hourly.toEntities(),
      days: daily.toEntities(),
    );
  }
}
