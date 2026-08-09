// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherForecastDto _$WeatherForecastDtoFromJson(Map<String, dynamic> json) =>
    _WeatherForecastDto(
      hourly: HourlyWeatherDto.fromJson(json['hourly'] as Map<String, dynamic>),
      daily: DailyForecastDto.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherForecastDtoToJson(_WeatherForecastDto instance) =>
    <String, dynamic>{'hourly': instance.hourly, 'daily': instance.daily};
