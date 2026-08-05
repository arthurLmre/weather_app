import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/data/entities/daily_weather.dart';
import 'package:weather_app/features/city_details/data/entities/hourly_weather.dart';
import 'package:weather_app/features/city_details/data/entities/weather_forecast.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_details/ui/page/components/city_details_view.dart';
import 'package:weather_app/features/city_details/ui/page/components/daily_weather_tile.dart';
import 'package:weather_app/features/city_details/ui/page/components/hourly_weather_card.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

final class MockCityDetailsCubit extends MockCubit<CityDetailsState>
    implements CityDetailsCubit {}

class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

void main() {
  late MockCityDetailsCubit cubit;
  late MockFavoritesCubit favoritesCubit;

  const city = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  setUpAll(() {
    registerFallbackValue(ActivityEnum.walking);
    registerFallbackValue(city);
  });

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
      HourlyWeather(
        dateTime: DateTime(2026, 8, 4, 15),
        weatherCode: 61,
        temperature: 22.1,
        apparentTemperature: 21.8,
        precipitationProbability: 60,
        precipitation: 1.2,
        windSpeed: 15.2,
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
      DailyWeather(
        date: DateTime(2026, 8, 5),
        weatherCode: 61,
        minTemperature: 15,
        maxTemperature: 21,
        precipitationProbability: 70,
        precipitation: 4.2,
        maxWindSpeed: 22,
      ),
    ],
  );

  const recommendations = [
    ActivityRecommendationResult(
      recommendation: ActivityRecommendation.recommended,
      reason: 'Conditions agréables pour marcher',
    ),
    ActivityRecommendationResult(
      recommendation: ActivityRecommendation.possible,
      reason: 'Prévoyez une protection contre la pluie',
    ),
  ];

  CityDetailsSuccess buildSuccessState({
    ActivityEnum selectedActivity = ActivityEnum.walking,
  }) {
    return CityDetailsSuccess(
      forecast: forecast,
      selectedActivity: selectedActivity,
      recommendations: recommendations,
    );
  }

  setUp(() {
    cubit = MockCityDetailsCubit();
    favoritesCubit = MockFavoritesCubit();

    when(
      () => favoritesCubit.state,
    ).thenReturn(const FavoritesLoaded(favorites: []));
  });

  Widget buildSubject() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CityDetailsCubit>.value(value: cubit),
          BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
        ],
        child: const CityDetailsView(city: city),
      ),
    );
  }

  testWidgets('affiche le nom de la ville dans l’AppBar', (tester) async {
    when(() => cubit.state).thenReturn(const CityDetailsInitial());

    await tester.pumpWidget(buildSubject());

    expect(find.text('Lyon'), findsOneWidget);
  });

  testWidgets('affiche un loader dans l’état initial', (tester) async {
    when(() => cubit.state).thenReturn(const CityDetailsInitial());

    await tester.pumpWidget(buildSubject());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('affiche un loader pendant le chargement', (tester) async {
    when(() => cubit.state).thenReturn(const CityDetailsLoading());

    await tester.pumpWidget(buildSubject());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('affiche le message et le bouton en cas d’échec', (tester) async {
    when(
      () => cubit.state,
    ).thenReturn(const CityDetailsFailure(message: 'Une erreur est survenue.'));

    await tester.pumpWidget(buildSubject());

    expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
    expect(find.text('Une erreur est survenue.'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });

  testWidgets('relance le chargement lors d’un clic sur Réessayer', (
    tester,
  ) async {
    when(
      () => cubit.state,
    ).thenReturn(const CityDetailsFailure(message: 'Une erreur est survenue.'));
    when(
      () => cubit.loadForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(buildSubject());
    await tester.tap(find.text('Réessayer'));
    await tester.pump();

    verify(
      () => cubit.loadForecast(
        latitude: city.latitude,
        longitude: city.longitude,
      ),
    ).called(1);
  });

  testWidgets('affiche les sections et prévisions en cas de succès', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(buildSuccessState());

    await tester.pumpWidget(buildSubject());

    expect(find.text('Prochaines 24 heures'), findsOneWidget);
    expect(find.text('Activité extérieure'), findsOneWidget);
    expect(find.text('Prévisions sur 7 jours'), findsOneWidget);
    expect(find.byType(HourlyWeatherCard), findsNWidgets(2));
    expect(find.byType(DailyWeatherTile), findsWidgets);
    expect(find.text('Maintenant'), findsOneWidget);
    expect(find.text("Aujourd'hui"), findsOneWidget);
  });

  testWidgets('change l’activité sélectionnée', (tester) async {
    when(() => cubit.state).thenReturn(buildSuccessState());
    when(() => cubit.selectActivity(any())).thenReturn(null);

    await tester.pumpWidget(buildSubject());
    await tester.tap(find.text('Course'));
    await tester.pump();

    verify(() => cubit.selectActivity(ActivityEnum.running)).called(1);
  });

  testWidgets('relance le chargement lors du pull-to-refresh', (tester) async {
    when(() => cubit.state).thenReturn(buildSuccessState());
    when(
      () => cubit.loadForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(buildSubject());

    await tester.drag(find.byType(CustomScrollView), const Offset(0, 300));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    verify(
      () => cubit.loadForecast(
        latitude: city.latitude,
        longitude: city.longitude,
      ),
    ).called(1);
  });
}
