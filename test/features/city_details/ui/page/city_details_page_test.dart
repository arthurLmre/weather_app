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
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/data/service/activity_repository.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_details/ui/page/city_details_page.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

final class MockWeatherRepository extends Mock implements WeatherRepository {}

final class MockActivityRecommendationService extends Mock
    implements ActivityRecommendationService {}

final class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

void main() {
  late MockWeatherRepository weatherRepository;
  late MockActivityRecommendationService recommendationService;
  late CityDetailsCubit cubit;
  late MockFavoritesCubit favoritesCubit;

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

  setUpAll(() {
    registerFallbackValue(ActivityEnum.walking);
  });

  setUp(() {
    weatherRepository = MockWeatherRepository();
    recommendationService = MockActivityRecommendationService();
    favoritesCubit = MockFavoritesCubit();

    when(
      () => favoritesCubit.state,
    ).thenReturn(const FavoritesLoaded(favorites: []));

    when(
      () => weatherRepository.getForecast(
        cityId: any(named: 'cityId'),
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async => forecast);

    when(
      () => recommendationService.evaluate(
        activity: any(named: 'activity'),
        minimumTemperature: any(named: 'minimumTemperature'),
        maximumTemperature: any(named: 'maximumTemperature'),
        precipitationProbability: any(named: 'precipitationProbability'),
        maximumWindSpeed: any(named: 'maximumWindSpeed'),
      ),
    ).thenReturn(
      const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.recommended,
        reason: 'Conditions agréables',
      ),
    );

    cubit = CityDetailsCubit(
      weatherRepository: weatherRepository,
      recommendationService: recommendationService,
    );
  });

  tearDown(() => cubit.close());

  testWidgets('charge les prévisions avec les coordonnées de la ville', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<CityDetailsCubit>.value(value: cubit),
            BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
          ],
          child: const CityDetailsPage(city: city),
        ),
      ),
    );
    await tester.pumpAndSettle();

    verify(
      () => weatherRepository.getForecast(
        cityId: city.id,
        latitude: city.latitude,
        longitude: city.longitude,
      ),
    ).called(1);
  });
}
