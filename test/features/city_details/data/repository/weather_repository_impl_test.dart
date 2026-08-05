import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source.dart';
import 'package:weather_app/features/city_details/data/datasources/remote/weather_data_source.dart';
import 'package:weather_app/features/city_details/data/models/daily_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/hourly_weather_dto.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository_impl.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {}

class MockWeatherCacheDataSource extends Mock
    implements WeatherCacheDataSource {}

void main() {
  late WeatherDataSource weatherDataSource;
  late WeatherCacheDataSource weatherCacheDataSource;
  late WeatherRepositoryImpl repository;
  late WeatherForecastDto forecastDto;

  const cityId = 2996944;
  const latitude = 46.205;
  const longitude = 5.225;

  setUp(() {
    weatherDataSource = MockWeatherDataSource();
    weatherCacheDataSource = MockWeatherCacheDataSource();

    repository = WeatherRepositoryImpl(
      weatherDataSource: weatherDataSource,
      cacheDataSource: weatherCacheDataSource,
    );

    forecastDto = const WeatherForecastDto(
      hourly: HourlyWeatherDto(
        dates: ['2026-08-04T14:00'],
        weatherCodes: [0],
        temperatures: [25],
        apparentTemperatures: [26],
        precipitationProbabilities: [10],
        precipitations: [0],
        windSpeeds: [8],
      ),
      daily: DailyForecastDto(
        dates: ['2026-08-04'],
        weatherCodes: [0],
        minTemperatures: [15],
        maxTemperatures: [27],
        precipitationProbabilities: [10],
        maxWindSpeeds: [15],
        precipitations: [0],
      ),
    );
  });

  group('WeatherRepositoryImpl', () {
    test('returns converted forecast when data source succeeds', () async {
      when(
        () => weatherDataSource.getForecast(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => forecastDto);

      when(
        () => weatherCacheDataSource.saveForecast(
          cityId: cityId,
          forecast: forecastDto,
        ),
      ).thenAnswer((_) async {});

      final result = await repository.getForecast(
        cityId: cityId,
        latitude: latitude,
        longitude: longitude,
      );

      expect(result.hours, hasLength(1));
      expect(result.days, hasLength(1));

      expect(result.hours.first.dateTime, DateTime(2026, 8, 4, 14));
      expect(result.hours.first.weatherCode, 0);
      expect(result.hours.first.temperature, 25);
      expect(result.hours.first.apparentTemperature, 26);
      expect(result.hours.first.precipitationProbability, 10);
      expect(result.hours.first.precipitation, 0);
      expect(result.hours.first.windSpeed, 8);

      expect(result.days.first.date, DateTime(2026, 8, 4));
      expect(result.days.first.weatherCode, 0);
      expect(result.days.first.minTemperature, 15);
      expect(result.days.first.maxTemperature, 27);
      expect(result.days.first.precipitationProbability, 10);
      expect(result.days.first.precipitation, 0);
      expect(result.days.first.maxWindSpeed, 15);

      verify(
        () => weatherDataSource.getForecast(
          latitude: latitude,
          longitude: longitude,
        ),
      ).called(1);

      verify(
        () => weatherCacheDataSource.saveForecast(
          cityId: cityId,
          forecast: forecastDto,
        ),
      ).called(1);

      verifyNoMoreInteractions(weatherDataSource);
      verifyNoMoreInteractions(weatherCacheDataSource);
    });

    test(
      'propagates exception when data source fails and cache is empty',
      () async {
        final exception = Exception('Network error');

        when(
          () => weatherDataSource.getForecast(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(exception);

        when(
          () =>
              weatherCacheDataSource.getForecast(cityId: any(named: 'cityId')),
        ).thenAnswer((_) async => null);

        expect(
          () => repository.getForecast(
            cityId: cityId,
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(same(exception)),
        );

        verify(
          () => weatherDataSource.getForecast(
            latitude: latitude,
            longitude: longitude,
          ),
        ).called(1);

        verify(
          () => weatherCacheDataSource.getForecast(cityId: cityId),
        ).called(1);

        verifyNoMoreInteractions(weatherDataSource);
        verifyNoMoreInteractions(weatherCacheDataSource);
      },
    );
  });
}
