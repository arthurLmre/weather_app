import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({required this.city, super.key});

  final City city;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = switch (state) {
          FavoritesLoaded(:final favorites) => favorites.any(
            (favorite) => favorite.id == city.id,
          ),
          _ => false,
        };

        return IconButton(
          tooltip: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
          onPressed: state is FavoritesLoading
              ? null
              : () {
                  context.read<FavoritesCubit>().toggleFavorite(city);
                },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        );
      },
    );
  }
}
