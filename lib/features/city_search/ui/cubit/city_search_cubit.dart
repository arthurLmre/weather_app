import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';

part 'city_search_state.dart';

class CitySearchCubit extends Cubit<CitySearchState> {
  CitySearchCubit({required this._repository})
    : super(const CitySearchInitial());

  final CitySearchRepository _repository;

  Future<void> searchCities(String query) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.length < 3) {
      emit(const CitySearchInitial());
      return;
    }

    emit(const CitySearchLoading());

    try {
      final cities = await _repository.searchCities(normalizedQuery);

      if (cities.isEmpty) {
        emit(const CitySearchEmpty());
        return;
      }

      emit(CitySearchSuccess(cities: cities));
    } catch (_) {
      emit(
        const CitySearchFailure(
          message: 'Impossible de rechercher les villes.',
        ),
      );
    }
  }
}
