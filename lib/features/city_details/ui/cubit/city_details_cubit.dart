import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';

part 'city_details_state.dart';

final class CityDetailsCubit extends Cubit<CityDetailsState> {
  CityDetailsCubit({required this._weatherRepository})
    : super(const CityDetailsInitial());

  final WeatherRepository _weatherRepository;

  Future<void> loadForecast({
    required double latitude,
    required double longitude,
  }) async {
    emit(const CityDetailsLoading());

    try {
      final forecast = await _weatherRepository.getForecast(
        latitude: latitude,
        longitude: longitude,
      );

      emit(CityDetailsSuccess(forecast: forecast));
    } catch (_) {
      emit(
        const CityDetailsFailure(
          message: 'Impossible de récupérer les prévisions météo.',
        ),
      );
    }
  }
}
