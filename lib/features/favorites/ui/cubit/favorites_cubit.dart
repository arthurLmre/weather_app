import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this._repository}) : super(const FavoritesInitial());

  final FavoritesRepository _repository;

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());

    try {
      final favorites = await _repository.getFavorites();

      emit(FavoritesLoaded(favorites: favorites));
    } catch (_) {
      emit(
        const FavoritesFailure(message: 'Impossible de charger les favoris.'),
      );
    }
  }

  Future<void> toggleFavorite(City city) async {
    try {
      await _repository.toggleFavorite(city);

      final favorites = await _repository.getFavorites();

      emit(FavoritesLoaded(favorites: favorites));
    } catch (_) {
      emit(
        const FavoritesFailure(message: 'Impossible de modifier les favoris.'),
      );
    }
  }

  bool isFavorite(City city) {
    final currentState = state;

    if (currentState is! FavoritesLoaded) {
      return false;
    }

    return currentState.favorites.any((favorite) => favorite.id == city.id);
  }
}
