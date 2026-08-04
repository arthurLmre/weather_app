part of 'city_details_cubit.dart';

sealed class CityDetailsState {
  const CityDetailsState();
}

final class CityDetailsInitial extends CityDetailsState {
  const CityDetailsInitial();
}

final class CityDetailsLoading extends CityDetailsState {
  const CityDetailsLoading();
}

final class CityDetailsSuccess extends CityDetailsState {
  const CityDetailsSuccess({
    required this.forecast,
    required this.selectedActivity,
    required this.recommendations,
  });

  final WeatherForecast forecast;
  final ActivityEnum selectedActivity;
  final List<ActivityRecommendationResult> recommendations;

  CityDetailsSuccess copyWith({
    WeatherForecast? forecast,
    ActivityEnum? selectedActivity,
    List<ActivityRecommendationResult>? recommendations,
  }) {
    return CityDetailsSuccess(
      forecast: forecast ?? this.forecast,
      selectedActivity: selectedActivity ?? this.selectedActivity,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}

final class CityDetailsFailure extends CityDetailsState {
  const CityDetailsFailure({required this.message});

  final String message;
}
