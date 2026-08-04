import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';

class CitySearchPage extends StatelessWidget {
  const CitySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rechercher une ville')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Lyon, Marseille, Paris...',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                context.read<CitySearchCubit>().searchImmediately(query);
              },
              onChanged: context.read<CitySearchCubit>().onQueryChanged,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CitySearchCubit, CitySearchState>(
                builder: (context, state) {
                  return switch (state) {
                    CitySearchInitial() => const Center(
                      child: Text('Saisis au moins 3 caractères.'),
                    ),
                    CitySearchLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CitySearchEmpty() => const Center(
                      child: Text('Aucune ville trouvée.'),
                    ),
                    CitySearchFailure(:final message) => Center(
                      child: Text(message),
                    ),
                    CitySearchSuccess(:final cities) => ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        final city = cities[index];

                        return ListTile(
                          title: Text(city.name),
                          subtitle: Text(
                            [city.region, city.country]
                                .whereType<String>()
                                .where((value) => value.isNotEmpty)
                                .join(', '),
                          ),
                        );
                      },
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
