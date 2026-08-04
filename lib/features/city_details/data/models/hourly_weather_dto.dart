import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/city_details/data/entities/hourly_weather.dart';

part 'hourly_weather_dto.freezed.dart';
part 'hourly_weather_dto.g.dart';

@freezed
abstract class HourlyWeatherDto with _$HourlyWeatherDto {
  const HourlyWeatherDto._();

  const factory HourlyWeatherDto({
    @JsonKey(name: 'time') required List<String> dates,
    @JsonKey(name: 'weather_code') required List<int> weatherCodes,
    @JsonKey(name: 'temperature_2m') required List<double> temperatures,
    @JsonKey(name: 'apparent_temperature')
    required List<double> apparentTemperatures,
    @JsonKey(name: 'precipitation_probability')
    required List<int> precipitationProbabilities,
    @JsonKey(name: 'precipitation') required List<double> precipitations,
    @JsonKey(name: 'wind_speed_10m') required List<double> windSpeeds,
  }) = _HourlyWeatherDto;

  factory HourlyWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherDtoFromJson(json);

  List<HourlyWeather> toEntities() {
    _validateLengths();

    return List.generate(
      dates.length,
      (index) => HourlyWeather(
        dateTime: DateTime.parse(dates[index]),
        weatherCode: weatherCodes[index],
        temperature: temperatures[index],
        apparentTemperature: apparentTemperatures[index],
        precipitationProbability: precipitationProbabilities[index],
        precipitation: precipitations[index],
        windSpeed: windSpeeds[index],
      ),
      growable: false,
    );
  }

  void _validateLengths() {
    final expectedLength = dates.length;

    if (weatherCodes.length != expectedLength ||
        temperatures.length != expectedLength ||
        apparentTemperatures.length != expectedLength ||
        precipitationProbabilities.length != expectedLength ||
        precipitations.length != expectedLength ||
        windSpeeds.length != expectedLength) {
      throw const FormatException(
        'Les listes de prévisions horaires ont des longueurs incohérentes.',
      );
    }
  }
}
