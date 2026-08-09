import 'package:flutter/material.dart';
import 'package:weather_app/features/city_details/data/entities/hourly_weather.dart';
import 'package:weather_app/features/city_details/ui/page/components/weather_conditions.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({
    required this.weather,
    required this.isCurrent,
    super.key,
  });

  final HourlyWeather weather;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final hour = TimeOfDay.fromDateTime(weather.dateTime).format(context);

    return SizedBox(
      width: 116,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isCurrent ? 'Maintenant' : hour,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              Icon(WeatherCondition.icon(weather.weatherCode), size: 36),
              const SizedBox(height: 8),
              Text(
                '${weather.temperature.round()}°',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Ressenti ${weather.apparentTemperature.round()}°',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _Metric(
                icon: Icons.water_drop_outlined,
                text: '${weather.precipitationProbability} %',
              ),
              const SizedBox(height: 6),
              _Metric(
                icon: Icons.air,
                text: '${weather.windSpeed.round()} km/h',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Flexible(
          child: Text(text, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
