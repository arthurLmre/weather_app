part of 'city_search_cubit.dart';

sealed class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object?> get props => const [];
}

final class CitySearchInitial extends CitySearchState {
  const CitySearchInitial();
}

final class CitySearchLoading extends CitySearchState {
  const CitySearchLoading();
}

final class CitySearchEmpty extends CitySearchState {
  const CitySearchEmpty();
}

final class CitySearchSuccess extends CitySearchState {
  const CitySearchSuccess({required this.cities});

  final List<City> cities;

  @override
  List<Object?> get props => [cities];
}

final class CitySearchFailure extends CitySearchState {
  const CitySearchFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
