import 'package:flutter/material.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';
import 'package:weather_app/features/city_details/ui/page/components/weather_conditions.dart';

class DailyWeatherTile extends StatelessWidget {
  const DailyWeatherTile({
    required this.weather,
    required this.isToday,
    super.key,
  });

  final DailyWeather weather;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 92,
                  child: Text(
                    isToday ? "Aujourd'hui" : _weekday(weather.date.weekday),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Icon(WeatherCondition.icon(weather.weatherCode), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(WeatherCondition.label(weather.weatherCode)),
                ),
                Text(
                  '${weather.minTemperature.round()}° / '
                  '${weather.maxTemperature.round()}°',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.water_drop_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${weather.precipitationProbability} %'
                    ' · ${weather.precipitation.toStringAsFixed(1)} mm',
                  ),
                ),
                const Icon(Icons.air, size: 18),
                const SizedBox(width: 6),
                Text('${weather.maxWindSpeed.round()} km/h'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _weekday(int weekday) {
    return switch (weekday) {
      DateTime.monday => 'Lundi',
      DateTime.tuesday => 'Mardi',
      DateTime.wednesday => 'Mercredi',
      DateTime.thursday => 'Jeudi',
      DateTime.friday => 'Vendredi',
      DateTime.saturday => 'Samedi',
      DateTime.sunday => 'Dimanche',
      _ => '',
    };
  }
}
