import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/features/city_details/data/datasources/endpoints/weather_endpoints.dart';
import 'package:weather_app/features/city_details/data/datasources/weather_data_source_impl.dart';

final class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient apiClient;
  late WeatherDataSourceImpl dataSource;

  const latitude = 45.7485;
  const longitude = 4.8467;

  final validJson = <String, dynamic>{
    'hourly': <String, dynamic>{
      'time': ['2026-08-04T14:00'],
      'weather_code': [61],
      'temperature_2m': [21.4],
      'apparent_temperature': [20.2],
      'precipitation_probability': [70],
      'precipitation': [1.5],
      'wind_speed_10m': [14.8],
    },
    'daily': <String, dynamic>{
      'time': ['2026-08-04'],
      'weather_code': [3],
      'temperature_2m_min': [14.2],
      'temperature_2m_max': [24.8],
      'precipitation_probability_max': [30],
      'precipitation_sum': [0.6],
      'wind_speed_10m_max': [18.7],
    },
  };

  final expectedQueryParameters = <String, dynamic>{
    'latitude': latitude,
    'longitude': longitude,
    'hourly': [
      'weather_code',
      'temperature_2m',
      'apparent_temperature',
      'precipitation_probability',
      'precipitation',
      'wind_speed_10m',
    ].join(','),
    'daily': [
      'weather_code',
      'temperature_2m_min',
      'temperature_2m_max',
      'precipitation_probability_max',
      'precipitation_sum',
      'wind_speed_10m_max',
    ].join(','),
    'forecast_hours': 24,
    'forecast_days': 7,
    'timezone': 'auto',
  };

  setUp(() {
    apiClient = MockApiClient();
    dataSource = WeatherDataSourceImpl(apiClient: apiClient);
  });

  group('WeatherDataSourceImpl.getForecast', () {
    test('appelle le bon endpoint avec les bons paramètres', () async {
      when(
        () => apiClient.get(
          WeatherEndpoints.forecast,
          queryParameters: expectedQueryParameters,
        ),
      ).thenAnswer((_) async => validJson);

      await dataSource.getForecast(latitude: latitude, longitude: longitude);

      verify(
        () => apiClient.get(
          WeatherEndpoints.forecast,
          queryParameters: expectedQueryParameters,
        ),
      ).called(1);
      verifyNoMoreInteractions(apiClient);
    });

    test('convertit la réponse JSON en WeatherForecastDto', () async {
      when(
        () => apiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => validJson);

      final result = await dataSource.getForecast(
        latitude: latitude,
        longitude: longitude,
      );

      expect(result.hourly.dates, ['2026-08-04T14:00']);
      expect(result.hourly.weatherCodes, [61]);
      expect(result.hourly.temperatures, [21.4]);
      expect(result.hourly.apparentTemperatures, [20.2]);
      expect(result.hourly.precipitationProbabilities, [70]);
      expect(result.hourly.precipitations, [1.5]);
      expect(result.hourly.windSpeeds, [14.8]);

      expect(result.daily.dates, ['2026-08-04']);
      expect(result.daily.weatherCodes, [3]);
      expect(result.daily.minTemperatures, [14.2]);
      expect(result.daily.maxTemperatures, [24.8]);
      expect(result.daily.precipitationProbabilities, [30]);
      expect(result.daily.precipitations, [0.6]);
      expect(result.daily.maxWindSpeeds, [18.7]);
    });

    test('propage une exception du client réseau', () async {
      final exception = Exception('Erreur réseau');

      when(
        () => apiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(exception);

      expect(
        () => dataSource.getForecast(latitude: latitude, longitude: longitude),
        throwsA(same(exception)),
      );
    });

    test('propage une erreur lorsque le JSON est invalide', () async {
      when(
        () => apiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => <String, dynamic>{});

      await expectLater(
        dataSource.getForecast(latitude: latitude, longitude: longitude),
        throwsA(anything),
      );
    });
  });
}
