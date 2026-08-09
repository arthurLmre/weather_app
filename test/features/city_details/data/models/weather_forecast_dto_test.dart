import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';

void main() {
  test('toEntity converts hourly and daily forecasts', () {
    const dto = WeatherForecastDto(
      hourly: HourlyWeatherDto(
        dates: ['2026-08-04T14:00'],
        weatherCodes: [0],
        temperatures: [25],
        apparentTemperatures: [26],
        precipitationProbabilities: [0],
        precipitations: [0],
        windSpeeds: [5],
      ),
      daily: DailyForecastDto(
        dates: ['2026-08-04'],
        weatherCodes: [0],
        minTemperatures: [15],
        maxTemperatures: [27],
        precipitationProbabilities: [0],
        maxWindSpeeds: [10],
        precipitations: [0],
      ),
    );

    final result = dto.toEntity();

    expect(result.hours, hasLength(1));
    expect(result.days, hasLength(1));
    expect(result.hours.first.temperature, 25);
    expect(result.days.first.maxTemperature, 27);
  });
}
