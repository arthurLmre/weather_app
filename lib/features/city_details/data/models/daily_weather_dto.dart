import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';

part 'daily_weather_dto.freezed.dart';
part 'daily_weather_dto.g.dart';

@freezed
abstract class DailyForecastDto with _$DailyForecastDto {
  const DailyForecastDto._();

  const factory DailyForecastDto({
    @JsonKey(name: 'time') required List<String> dates,
    @JsonKey(name: 'weather_code') required List<int> weatherCodes,
    @JsonKey(name: 'temperature_2m_min') required List<double> minTemperatures,
    @JsonKey(name: 'temperature_2m_max') required List<double> maxTemperatures,
    @JsonKey(name: 'precipitation_probability_max')
    required List<int> precipitationProbabilities,
    @JsonKey(name: 'wind_speed_10m_max') required List<double> maxWindSpeeds,
    @JsonKey(name: 'precipitation_sum') required List<double> precipitations,
  }) = _DailyForecastDto;

  factory DailyForecastDto.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastDtoFromJson(json);

  List<DailyWeather> toEntities() {
    _validateLengths();

    return List.generate(
      dates.length,
      (index) => DailyWeather(
        date: DateTime.parse(dates[index]),
        weatherCode: weatherCodes[index],
        minTemperature: minTemperatures[index],
        maxTemperature: maxTemperatures[index],
        precipitationProbability: precipitationProbabilities[index],
        maxWindSpeed: maxWindSpeeds[index],
        precipitation: precipitations[index],
      ),
      growable: false,
    );
  }

  void _validateLengths() {
    final expectedLength = dates.length;

    if (weatherCodes.length != expectedLength ||
        minTemperatures.length != expectedLength ||
        maxTemperatures.length != expectedLength ||
        precipitationProbabilities.length != expectedLength ||
        maxWindSpeeds.length != expectedLength ||
        precipitations.length != expectedLength) {
      throw const FormatException(
        'Les listes de prévisions météo ont des longueurs incohérentes.',
      );
    }
  }
}
