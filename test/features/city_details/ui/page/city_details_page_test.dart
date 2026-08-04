import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';
import 'package:weather_app/features/city_details/data/entities/hourly_weather.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/ui/page/city_details_page.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

final class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository weatherRepository;

  const city = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  final forecast = WeatherForecast(
    hours: [
      HourlyWeather(
        dateTime: DateTime(2026, 8, 4, 14),
        weatherCode: 0,
        temperature: 24.6,
        apparentTemperature: 25.4,
        precipitationProbability: 10,
        precipitation: 0,
        windSpeed: 12.7,
      ),
    ],
    days: [
      DailyWeather(
        date: DateTime(2026, 8, 4),
        weatherCode: 0,
        minTemperature: 14.2,
        maxTemperature: 24.8,
        precipitationProbability: 30,
        precipitation: 1.2,
        maxWindSpeed: 18.7,
      ),
    ],
  );

  setUp(() {
    weatherRepository = MockWeatherRepository();
  });

  Widget buildSubject() {
    return RepositoryProvider<WeatherRepository>.value(
      value: weatherRepository,
      child: const MaterialApp(home: CityDetailsPage(city: city)),
    );
  }

  testWidgets('charge automatiquement les prévisions au montage', (
    tester,
  ) async {
    when(
      () => weatherRepository.getForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async => forecast);

    await tester.pumpWidget(buildSubject());
    await tester.pump();

    verify(
      () => weatherRepository.getForecast(
        latitude: city.latitude,
        longitude: city.longitude,
      ),
    ).called(1);
  });

  testWidgets('affiche le nom de la ville', (tester) async {
    when(
      () => weatherRepository.getForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async => forecast);

    await tester.pumpWidget(buildSubject());

    expect(find.text('Lyon'), findsOneWidget);
  });

  testWidgets('affiche les prévisions après le chargement', (tester) async {
    when(
      () => weatherRepository.getForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async => forecast);

    await tester.pumpWidget(buildSubject());
    await tester.pump();

    expect(find.text('Prochaines 24 heures'), findsOneWidget);
    expect(find.text('Prévisions sur 7 jours'), findsOneWidget);
    expect(find.text('Maintenant'), findsOneWidget);
    expect(find.text("Aujourd'hui"), findsOneWidget);
  });

  testWidgets('affiche l’état d’erreur lorsque le repository échoue', (
    tester,
  ) async {
    when(
      () => weatherRepository.getForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenThrow(Exception('Erreur réseau'));

    await tester.pumpWidget(buildSubject());
    await tester.pump();

    expect(
      find.text('Impossible de récupérer les prévisions météo.'),
      findsOneWidget,
    );
    expect(find.text('Réessayer'), findsOneWidget);
  });
}
