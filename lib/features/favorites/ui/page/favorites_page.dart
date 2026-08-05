import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/city_search/ui/page/components/city_card.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return switch (state) {
            FavoritesInitial() || FavoritesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            FavoritesFailure(:final message) => Center(child: Text(message)),
            FavoritesLoaded(favorites: final favorites)
                when favorites.isEmpty =>
              const _EmptyFavoritesView(),
            FavoritesLoaded(favorites: final favorites) => CustomScrollView(
              slivers: [
                const SliverAppBar(title: Text('Mes favoris'), floating: true),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.separated(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final city = favorites[index];

                      return CityCard(
                        city: city,
                        leadingIcon: Icons.favorite,
                        onTap: () {
                          context.pushNamed('cityDetails', extra: city);
                        },
                        trailing: IconButton(
                          tooltip: 'Retirer des favoris',
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            context.read<FavoritesCubit>().toggleFavorite(city);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                  ),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}

class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(title: Text('Mes favoris'), floating: true),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucune ville favorite',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ajoutez une ville depuis sa fiche météo.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
