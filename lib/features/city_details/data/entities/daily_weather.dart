import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_weather.freezed.dart';

@freezed
abstract class DailyWeather with _$DailyWeather {
  const factory DailyWeather({
    required DateTime date,
    required int weatherCode,
    required double minTemperature,
    required double maxTemperature,
    required int precipitationProbability,
    required double precipitation,
    required double maxWindSpeed,
  }) = _DailyWeather;
}
