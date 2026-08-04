import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';
import 'package:weather_app/features/city_details/ui/page/components/daily_weather_tile.dart';

void main() {
  DailyWeather buildWeather({DateTime? date}) {
    return DailyWeather(
      date: date ?? DateTime(2026, 8, 4),
      weatherCode: 0,
      minTemperature: 14.2,
      maxTemperature: 24.8,
      precipitationProbability: 30,
      precipitation: 1.24,
      maxWindSpeed: 18.7,
    );
  }

  Widget buildSubject({
    required DailyWeather weather,
    required bool isToday,
    ActivityRecommendationResult recommendation =
        const ActivityRecommendationResult(
          recommendation: ActivityRecommendation.recommended,
          reason: 'Conditions agréables',
        ),
  }) {
    return MaterialApp(
      home: Scaffold(
        body: DailyWeatherTile(
          weather: weather,
          isToday: isToday,
          recommendation: recommendation,
        ),
      ),
    );
  }

  testWidgets("affiche Aujourd'hui pour le premier jour", (tester) async {
    await tester.pumpWidget(
      buildSubject(weather: buildWeather(), isToday: true),
    );

    expect(find.text("Aujourd'hui"), findsOneWidget);
  });

  testWidgets('affiche le nom du jour pour les jours suivants', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        weather: buildWeather(date: DateTime(2026, 8, 3)),
        isToday: false,
      ),
    );

    expect(find.text('Lundi'), findsOneWidget);
    expect(find.text("Aujourd'hui"), findsNothing);
  });

  testWidgets('affiche les conditions et températures arrondies', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(weather: buildWeather(), isToday: true),
    );

    expect(find.text('Ciel dégagé'), findsOneWidget);
    expect(find.text('14° / 25°'), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);
  });

  testWidgets('affiche les précipitations et le vent', (tester) async {
    await tester.pumpWidget(
      buildSubject(weather: buildWeather(), isToday: true),
    );

    expect(find.text('30 % · 1.2 mm'), findsOneWidget);
    expect(find.text('19 km/h'), findsOneWidget);
    expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);
    expect(find.byIcon(Icons.air), findsOneWidget);
  });
}
