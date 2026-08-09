import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/router/app_routes.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';
import 'package:weather_app/features/city_search/ui/page/components/initial_content.dart';
import 'package:weather_app/features/city_search/ui/page/components/message_content.dart';
import 'package:weather_app/features/city_search/ui/page/components/search_history_sliver_list.dart';
import 'package:weather_app/features/city_search/ui/page/components/search_results_sliver_list.dart';

class CitySearchPage extends StatefulWidget {
  const CitySearchPage({super.key});

  @override
  State<CitySearchPage> createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchTextChanged)
      ..dispose();

    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();

    context.read<CitySearchCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final hasSearchText = _searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Rechercher une ville')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Lyon, Marseille, Paris...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: hasSearchText
                      ? IconButton(
                          key: const Key('clear-search-button'),
                          tooltip: 'Effacer la recherche',
                          icon: const Icon(Icons.close),
                          onPressed: _clearSearch,
                        )
                      : null,
                ),
                onSubmitted: (query) {
                  context.read<CitySearchCubit>().searchImmediately(query);
                },
                onChanged: context.read<CitySearchCubit>().onQueryChanged,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<CitySearchCubit, CitySearchState>(
                  builder: (context, state) {
                    return switch (state) {
                      CitySearchInitial() => const InitialContent(),

                      CitySearchHistory(:final cities) =>
                        SearchHistorySliverList(
                          cities: cities,
                          onCitySelected: (city) {
                            _selectCity(context, city);
                          },
                          onCityDeleted: (city) {
                            context
                                .read<CitySearchCubit>()
                                .removeCityFromHistory(city);
                          },
                          onClearHistory: () {
                            context.read<CitySearchCubit>().clearHistory();
                          },
                        ),

                      CitySearchLoading() => const Center(
                        child: CircularProgressIndicator(),
                      ),

                      CitySearchEmpty() => const MessageContent(
                        icon: Icons.search_off,
                        title: 'Aucune ville trouvée',
                        message: 'Essaie avec un autre nom de ville.',
                      ),

                      CitySearchFailure(:final message) => MessageContent(
                        icon: Icons.cloud_off_outlined,
                        title: 'Recherche impossible',
                        message: message,
                      ),

                      CitySearchSuccess(:final cities) =>
                        SearchResultsSliverList(
                          cities: cities,
                          onCitySelected: (city) {
                            _selectCity(context, city);
                          },
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectCity(BuildContext context, City city) async {
    await context.read<CitySearchCubit>().selectCity(city);

    if (!context.mounted) return;

    context.push(AppRoutes.cityDetails, extra: city);
  }
}
