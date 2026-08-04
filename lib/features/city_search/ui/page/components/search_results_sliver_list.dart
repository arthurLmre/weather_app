import 'package:flutter/material.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/page/components/city_card.dart';

class SearchResultsSliverList extends StatelessWidget {
  const SearchResultsSliverList({
    super.key,
    required this.cities,
    required this.onCitySelected,
  });

  final List<City> cities;
  final ValueChanged<City> onCitySelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${cities.length} résultat${cities.length > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.titleSmall,
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
                child: CityCard(
                  city: city,
                  leadingIcon: Icons.location_on_outlined,
                  onTap: () => onCitySelected(city),
                ),
              );
            }, childCount: cities.length),
          ),
        ),
      ],
    );
  }
}
