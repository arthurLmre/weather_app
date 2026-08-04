// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HourlyWeatherDto _$HourlyWeatherDtoFromJson(Map<String, dynamic> json) =>
    _HourlyWeatherDto(
      dates: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      weatherCodes: (json['weather_code'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      temperatures: (json['temperature_2m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      apparentTemperatures: (json['apparent_temperature'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      precipitationProbabilities:
          (json['precipitation_probability'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      precipitations: (json['precipitation'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      windSpeeds: (json['wind_speed_10m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$HourlyWeatherDtoToJson(_HourlyWeatherDto instance) =>
    <String, dynamic>{
      'time': instance.dates,
      'weather_code': instance.weatherCodes,
      'temperature_2m': instance.temperatures,
      'apparent_temperature': instance.apparentTemperatures,
      'precipitation_probability': instance.precipitationProbabilities,
      'precipitation': instance.precipitations,
      'wind_speed_10m': instance.windSpeeds,
    };
