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
  const CityDetailsSuccess({required this.forecast});

  final WeatherForecast forecast;
}

final class CityDetailsFailure extends CityDetailsState {
  const CityDetailsFailure({required this.message});

  final String message;
}
