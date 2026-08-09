// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyForecastDto _$DailyForecastDtoFromJson(Map<String, dynamic> json) =>
    _DailyForecastDto(
      dates: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      weatherCodes: (json['weather_code'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      minTemperatures: (json['temperature_2m_min'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      maxTemperatures: (json['temperature_2m_max'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      precipitationProbabilities:
          (json['precipitation_probability_max'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      maxWindSpeeds: (json['wind_speed_10m_max'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      precipitations: (json['precipitation_sum'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$DailyForecastDtoToJson(_DailyForecastDto instance) =>
    <String, dynamic>{
      'time': instance.dates,
      'weather_code': instance.weatherCodes,
      'temperature_2m_min': instance.minTemperatures,
      'temperature_2m_max': instance.maxTemperatures,
      'precipitation_probability_max': instance.precipitationProbabilities,
      'wind_speed_10m_max': instance.maxWindSpeeds,
      'precipitation_sum': instance.precipitations,
    };
