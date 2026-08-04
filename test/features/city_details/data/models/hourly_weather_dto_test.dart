import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';

void main() {
  test('toEntities converts hourly values to domain entities', () {
    const dto = HourlyWeatherDto(
      dates: ['2026-08-04T14:00'],
      weatherCodes: [61],
      temperatures: [21.4],
      apparentTemperatures: [20.2],
      precipitationProbabilities: [70],
      precipitations: [1.5],
      windSpeeds: [14.8],
    );

    final result = dto.toEntities();

    expect(result, hasLength(1));
    expect(result.first.dateTime, DateTime(2026, 8, 4, 14));
    expect(result.first.weatherCode, 61);
    expect(result.first.temperature, 21.4);
    expect(result.first.apparentTemperature, 20.2);
    expect(result.first.precipitationProbability, 70);
    expect(result.first.precipitation, 1.5);
    expect(result.first.windSpeed, 14.8);
  });
  test('throws FormatException when list lengths are inconsistent', () {
    const dto = HourlyWeatherDto(
      dates: ['2026-08-04T14:00', '2026-08-04T15:00'],
      weatherCodes: [61],
      temperatures: [21.4, 22],
      apparentTemperatures: [20.2, 21],
      precipitationProbabilities: [70, 40],
      precipitations: [1.5, 0],
      windSpeeds: [14.8, 10],
    );

    expect(dto.toEntities, throwsA(isA<FormatException>()));
  });
  test('returns an empty list when all lists are empty', () {
    const dto = HourlyWeatherDto(
      dates: [],
      weatherCodes: [],
      temperatures: [],
      apparentTemperatures: [],
      precipitationProbabilities: [],
      precipitations: [],
      windSpeeds: [],
    );

    expect(dto.toEntities(), isEmpty);
  });
  test('throws FormatException when a date is invalid', () {
    const dto = HourlyWeatherDto(
      dates: ['invalid-date'],
      weatherCodes: [0],
      temperatures: [20],
      apparentTemperatures: [20],
      precipitationProbabilities: [0],
      precipitations: [0],
      windSpeeds: [5],
    );

    expect(dto.toEntities, throwsA(isA<FormatException>()));
  });
}
