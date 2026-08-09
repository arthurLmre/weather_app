import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_weather.dart';
import 'hourly_weather.dart';

part 'weather_forecast.freezed.dart';

@freezed
abstract class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    required List<HourlyWeather> hours,
    required List<DailyWeather> days,
  }) = _WeatherForecast;
}
