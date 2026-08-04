import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/hourly_weather.dart';
import 'package:weather_app/features/city_details/ui/page/components/hourly_weather_card.dart';

void main() {
  final weather = HourlyWeather(
    dateTime: DateTime(2026, 8, 4, 14),
    weatherCode: 0,
    temperature: 24.6,
    apparentTemperature: 25.4,
    precipitationProbability: 10,
    precipitation: 0,
    windSpeed: 12.7,
  );

  Widget buildSubject({required bool isCurrent}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 260,
            child: HourlyWeatherCard(weather: weather, isCurrent: isCurrent),
          ),
        ),
      ),
    );
  }

  testWidgets('affiche Maintenant pour la météo courante', (tester) async {
    await tester.pumpWidget(buildSubject(isCurrent: true));

    expect(find.text('Maintenant'), findsOneWidget);
    expect(find.text('2:00 PM'), findsNothing);
  });

  testWidgets('affiche l’heure pour une prévision future', (tester) async {
    await tester.pumpWidget(buildSubject(isCurrent: false));

    expect(find.text('Maintenant'), findsNothing);
    expect(find.text('2:00 PM'), findsOneWidget);
  });

  testWidgets('affiche toutes les valeurs météo arrondies', (tester) async {
    await tester.pumpWidget(buildSubject(isCurrent: true));

    expect(find.text('25°'), findsOneWidget);
    expect(find.text('Ressenti 25°'), findsOneWidget);
    expect(find.text('10 %'), findsOneWidget);
    expect(find.text('13 km/h'), findsOneWidget);
  });

  testWidgets('affiche les icônes correspondant aux métriques', (tester) async {
    await tester.pumpWidget(buildSubject(isCurrent: true));

    expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);
    expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);
    expect(find.byIcon(Icons.air), findsOneWidget);
  });
}
