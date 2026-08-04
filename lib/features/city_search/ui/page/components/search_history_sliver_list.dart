import 'package:flutter/material.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/page/components/city_card.dart';

class SearchHistorySliverList extends StatelessWidget {
  const SearchHistorySliverList({
    super.key,
    required this.cities,
    required this.onCitySelected,
    required this.onCityDeleted,
    required this.onClearHistory,
  });

  final List<City> cities;
  final ValueChanged<City> onCitySelected;
  final ValueChanged<City> onCityDeleted;
  final VoidCallback onClearHistory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(Icons.history, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Recherches récentes',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onClearHistory,
                  child: const Text('Effacer'),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final city = cities[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Dismissible(
                  key: ValueKey(city.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                  confirmDismiss: (_) async {
                    return true;
                  },
                  onDismissed: (_) {
                    onCityDeleted(city);
                  },
                  child: CityCard(
                    city: city,
                    leadingIcon: Icons.history,
                    onTap: () => onCitySelected(city),
                  ),
                ),
              );
            }, childCount: cities.length),
          ),
        ),
      ],
    );
  }
}
