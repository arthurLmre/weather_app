import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';

void main() {
  test('toEntities converts daily values to domain entities', () {
    const dto = DailyForecastDto(
      dates: ['2026-08-04'],
      weatherCodes: [3],
      minTemperatures: [14.2],
      maxTemperatures: [24.8],
      precipitationProbabilities: [30],
      maxWindSpeeds: [18.7],
      precipitations: [0.6],
    );

    final result = dto.toEntities();

    expect(result, hasLength(1));
    expect(result.first.date, DateTime(2026, 8, 4));
    expect(result.first.weatherCode, 3);
    expect(result.first.minTemperature, 14.2);
    expect(result.first.maxTemperature, 24.8);
    expect(result.first.precipitationProbability, 30);
    expect(result.first.precipitation, 0.6);
    expect(result.first.maxWindSpeed, 18.7);
  });
}
