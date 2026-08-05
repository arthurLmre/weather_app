import 'package:weather_app/features/city_details/data/datasources/cache/weather_cache_data_source.dart';
import 'package:weather_app/features/city_details/data/datasources/remote/weather_data_source.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/models/weather_forecast_dto.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';

final class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required this._weatherDataSource,
    required this._cacheDataSource,
  });

  final WeatherDataSource _weatherDataSource;
  final WeatherCacheDataSource _cacheDataSource;

  @override
  Future<WeatherForecast> getForecast({
    required int cityId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final remoteForecast = await _weatherDataSource.getForecast(
        latitude: latitude,
        longitude: longitude,
      );

      await _saveForecastSafely(cityId: cityId, forecast: remoteForecast);

      return remoteForecast.toEntity();
    } catch (networkError, networkStackTrace) {
      final cachedForecast = await _cacheDataSource.getForecast(cityId: cityId);

      if (cachedForecast != null) {
        return cachedForecast.toEntity();
      }

      Error.throwWithStackTrace(networkError, networkStackTrace);
    }
  }

  Future<void> _saveForecastSafely({
    required int cityId,
    required WeatherForecastDto forecast,
  }) async {
    try {
      await _cacheDataSource.saveForecast(cityId: cityId, forecast: forecast);
    } catch (_) {
      // L'échec du cache ne doit pas bloquer les données réseau.
    }
  }
}
