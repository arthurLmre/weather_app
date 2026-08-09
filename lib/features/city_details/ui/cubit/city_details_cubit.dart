import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/data/service/activity_repository.dart';

part 'city_details_state.dart';

class CityDetailsCubit extends Cubit<CityDetailsState> {
  CityDetailsCubit({
    required this._weatherRepository,
    required this._recommendationService,
  }) : super(const CityDetailsInitial());

  final WeatherRepository _weatherRepository;
  final ActivityRecommendationService _recommendationService;

  ActivityEnum _selectedActivity = ActivityEnum.walking;

  Future<void> loadForecast({
    required double latitude,
    required double longitude,
    required int cityId,
  }) async {
    emit(const CityDetailsLoading());

    try {
      final forecast = await _weatherRepository.getForecast(
        cityId: cityId,
        latitude: latitude,
        longitude: longitude,
      );

      emit(
        CityDetailsSuccess(
          forecast: forecast,
          selectedActivity: _selectedActivity,
          recommendations: _buildRecommendations(
            days: forecast.days,
            activity: _selectedActivity,
          ),
        ),
      );
    } catch (_) {
      emit(
        const CityDetailsFailure(
          message: 'Impossible de récupérer les prévisions météo.',
        ),
      );
    }
  }

  void selectActivity(ActivityEnum activity) {
    final currentState = state;

    if (currentState is! CityDetailsSuccess) {
      return;
    }

    if (activity == currentState.selectedActivity) {
      return;
    }

    _selectedActivity = activity;

    emit(
      currentState.copyWith(
        selectedActivity: activity,
        recommendations: _buildRecommendations(
          days: currentState.forecast.days,
          activity: activity,
        ),
      ),
    );
  }

  List<ActivityRecommendationResult> _buildRecommendations({
    required List<DailyWeather> days,
    required ActivityEnum activity,
  }) {
    return days
        .map((weather) {
          return _recommendationService.evaluate(
            activity: activity,
            minimumTemperature: weather.minTemperature,
            maximumTemperature: weather.maxTemperature,
            precipitationProbability: weather.precipitationProbability,
            maximumWindSpeed: weather.maxWindSpeed,
          );
        })
        .toList(growable: false);
  }
}
