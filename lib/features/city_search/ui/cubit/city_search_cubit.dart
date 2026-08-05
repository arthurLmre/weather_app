import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';

part 'city_search_state.dart';

class CitySearchCubit extends Cubit<CitySearchState> {
  CitySearchCubit({
    required this._repository,
    this._debounceDuration = const Duration(milliseconds: 500),
  }) : super(const CitySearchInitial());

  final CitySearchRepository _repository;

  final Duration _debounceDuration;
  Timer? _debounceTimer;
  CancelToken? _cancelToken;

  void onQueryChanged(String query) async {
    _debounceTimer?.cancel();

    final normalizedQuery = query.trim();

    if (normalizedQuery.length < 3) {
      _cancelCurrentRequest();
      await loadHistory();

      return;
    }

    _debounceTimer = Timer(
      _debounceDuration,
      () => _performSearch(normalizedQuery),
    );
  }

  Future<void> searchImmediately(String query) async {
    _debounceTimer?.cancel();

    final normalizedQuery = query.trim();

    if (normalizedQuery.length < 3) {
      _cancelCurrentRequest();
      emit(const CitySearchInitial());
      return;
    }

    await _performSearch(normalizedQuery);
  }

  Future<void> _performSearch(String query) async {
    _cancelCurrentRequest();

    final cancelToken = CancelToken();
    _cancelToken = cancelToken;

    emit(const CitySearchLoading());

    try {
      final cities = await _repository.searchCities(
        query,
        cancelToken: cancelToken,
      );

      if (isClosed || cancelToken.isCancelled) {
        return;
      }

      emit(
        cities.isEmpty
            ? const CitySearchEmpty()
            : CitySearchSuccess(cities: cities),
      );
    } on ApiException catch (error) {
      if (isClosed ||
          cancelToken.isCancelled ||
          error.type == ApiExceptionType.cancelled) {
        return;
      }

      emit(CitySearchFailure(message: _getErrorMessage(error)));
    } finally {
      if (identical(_cancelToken, cancelToken)) {
        _cancelToken = null;
      }
    }
  }

  Future<void> clearSearch() async {
    _debounceTimer?.cancel();
    await loadHistory();
  }

  String _getErrorMessage(ApiException error) {
    return switch (error.type) {
      ApiExceptionType.connection => 'Vérifie ta connexion internet.',
      ApiExceptionType.timeout => 'Le service met trop de temps à répondre.',
      ApiExceptionType.badResponse => error.message,
      ApiExceptionType.cancelled => 'La recherche a été annulée.',
      ApiExceptionType.invalidData => 'Les données reçues sont invalides.',
      ApiExceptionType.unknown => 'Une erreur inattendue est survenue.',
    };
  }

  void _cancelCurrentRequest() {
    final token = _cancelToken;

    if (token != null && !token.isCancelled) {
      token.cancel('Nouvelle recherche démarrée.');
    }

    _cancelToken = null;
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> loadHistory() async {
    try {
      final history = await _repository.getSearchHistory();

      if (history.isEmpty) {
        emit(const CitySearchInitial());
        return;
      }

      emit(CitySearchHistory(history));
    } catch (_) {
      emit(const CitySearchInitial());
    }
  }

  Future<void> removeCityFromHistory(City city) async {
    await _repository.removeCityFromHistory(city);

    final currentState = state;

    if (currentState is! CitySearchHistory) {
      return;
    }

    final updatedHistory = currentState.cities
        .where((savedCity) => savedCity.id != city.id)
        .toList();

    if (updatedHistory.isEmpty) {
      emit(const CitySearchInitial());
      return;
    }

    emit(CitySearchHistory(updatedHistory));
  }

  Future<void> selectCity(City city) async {
    await _repository.addCityToHistory(city);
  }

  Future<void> clearHistory() async {
    await _repository.clearSearchHistory();
    emit(const CitySearchInitial());
  }
}
