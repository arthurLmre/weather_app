import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_details/ui/page/components/daily_weather_tile.dart';
import 'package:weather_app/features/city_details/ui/page/components/hourly_weather_card.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

class CityDetailsView extends StatelessWidget {
  const CityDetailsView({required this.city, super.key});

  final City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.name)),
      body: BlocBuilder<CityDetailsCubit, CityDetailsState>(
        builder: (context, state) {
          if (state is CityDetailsInitial || state is CityDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CityDetailsFailure) {
            return _FailureView(
              message: state.message,
              onRetry: () {
                context.read<CityDetailsCubit>().loadForecast(
                  latitude: city.latitude,
                  longitude: city.longitude,
                );
              },
            );
          }

          if (state is CityDetailsSuccess) {
            final forecast = state.forecast;

            return RefreshIndicator(
              onRefresh: () {
                return context.read<CityDetailsCubit>().loadForecast(
                  latitude: city.latitude,
                  longitude: city.longitude,
                );
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Prochaines 24 heures',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: forecast.hours.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 4),
                        itemBuilder: (context, index) {
                          return HourlyWeatherCard(
                            weather: forecast.hours[index],
                            isCurrent: index == 0,
                          );
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Prévisions sur 7 jours',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                    sliver: SliverList.separated(
                      itemCount: forecast.days.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        return DailyWeatherTile(
                          weather: forecast.days[index],
                          isToday: index == 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_outlined, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
