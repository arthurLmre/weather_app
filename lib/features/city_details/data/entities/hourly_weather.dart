import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_weather.freezed.dart';

@freezed
abstract class HourlyWeather with _$HourlyWeather {
  const factory HourlyWeather({
    required DateTime dateTime,
    required int weatherCode,
    required double temperature,
    required double apparentTemperature,
    required int precipitationProbability,
    required double precipitation,
    required double windSpeed,
  }) = _HourlyWeather;
}
