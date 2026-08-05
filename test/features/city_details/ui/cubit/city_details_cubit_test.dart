import 'package:bloc_test/bloc_test.dart';
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

final class MockWeatherRepository extends Mock implements WeatherRepository {}

final class MockActivityRecommendationService extends Mock
    implements ActivityRecommendationService {}

void main() {
  late MockWeatherRepository weatherRepository;
  late MockActivityRecommendationService recommendationService;

  final forecast = WeatherForecast(
    hours: [
      HourlyWeather(
        dateTime: DateTime(2026, 8, 4, 14),
        weatherCode: 0,
        temperature: 24,
        apparentTemperature: 25,
        precipitationProbability: 10,
        precipitation: 0,
        windSpeed: 12,
      ),
    ],
    days: [
      DailyWeather(
        date: DateTime(2026, 8, 4),
        weatherCode: 0,
        minTemperature: 14,
        maxTemperature: 25,
        precipitationProbability: 20,
        precipitation: 0,
        maxWindSpeed: 18,
      ),
      DailyWeather(
        date: DateTime(2026, 8, 5),
        weatherCode: 61,
        minTemperature: 12,
        maxTemperature: 20,
        precipitationProbability: 60,
        precipitation: 3,
        maxWindSpeed: 25,
      ),
    ],
  );

  const recommendedResult = ActivityRecommendationResult(
    recommendation: ActivityRecommendation.recommended,
    reason: 'Conditions agréables',
  );

  const possibleResult = ActivityRecommendationResult(
    recommendation: ActivityRecommendation.possible,
    reason: 'Conditions moyennes',
  );

  setUpAll(() {
    registerFallbackValue(ActivityEnum.walking);
  });

  setUp(() {
    weatherRepository = MockWeatherRepository();
    recommendationService = MockActivityRecommendationService();
  });

  CityDetailsCubit buildCubit() {
    return CityDetailsCubit(
      weatherRepository: weatherRepository,
      recommendationService: recommendationService,
    );
  }

  void stubForecastSuccess() {
    when(
      () => weatherRepository.getForecast(
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ).thenAnswer((_) async => forecast);
  }

  void stubRecommendations(List<ActivityRecommendationResult> results) {
    var callIndex = 0;

    when(
      () => recommendationService.evaluate(
        activity: any(named: 'activity'),
        minimumTemperature: any(named: 'minimumTemperature'),
        maximumTemperature: any(named: 'maximumTemperature'),
        precipitationProbability: any(named: 'precipitationProbability'),
        maximumWindSpeed: any(named: 'maximumWindSpeed'),
      ),
    ).thenAnswer((_) => results[callIndex++ % results.length]);
  }

  test('l’état initial est CityDetailsInitial', () {
    final cubit = buildCubit();

    expect(cubit.state, isA<CityDetailsInitial>());

    cubit.close();
  });

  blocTest<CityDetailsCubit, CityDetailsState>(
    'émet loading puis success et construit une recommandation par jour',
    setUp: () {
      stubForecastSuccess();
      stubRecommendations([recommendedResult, possibleResult]);
    },
    build: buildCubit,
    act: (cubit) => cubit.loadForecast(latitude: 45.75, longitude: 4.85),
    expect: () => [
      isA<CityDetailsLoading>(),
      isA<CityDetailsSuccess>()
          .having((state) => state.forecast, 'forecast', forecast)
          .having(
            (state) => state.selectedActivity,
            'selectedActivity',
            ActivityEnum.walking,
          )
          .having((state) => state.recommendations, 'recommendations', [
            recommendedResult,
            possibleResult,
          ]),
    ],
    verify: (_) {
      verify(
        () => weatherRepository.getForecast(latitude: 45.75, longitude: 4.85),
      ).called(1);

      verify(
        () => recommendationService.evaluate(
          activity: ActivityEnum.walking,
          minimumTemperature: 14,
          maximumTemperature: 25,
          precipitationProbability: 20,
          maximumWindSpeed: 18,
        ),
      ).called(1);

      verify(
        () => recommendationService.evaluate(
          activity: ActivityEnum.walking,
          minimumTemperature: 12,
          maximumTemperature: 20,
          precipitationProbability: 60,
          maximumWindSpeed: 25,
        ),
      ).called(1);
    },
  );

  blocTest<CityDetailsCubit, CityDetailsState>(
    'émet loading puis failure lorsque le repository échoue',
    setUp: () {
      when(
        () => weatherRepository.getForecast(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenThrow(Exception('Erreur réseau'));
    },
    build: buildCubit,
    act: (cubit) => cubit.loadForecast(latitude: 45.75, longitude: 4.85),
    expect: () => [
      isA<CityDetailsLoading>(),
      isA<CityDetailsFailure>().having(
        (state) => state.message,
        'message',
        'Impossible de récupérer les prévisions météo.',
      ),
    ],
    verify: (_) {
      verifyNever(
        () => recommendationService.evaluate(
          activity: any(named: 'activity'),
          minimumTemperature: any(named: 'minimumTemperature'),
          maximumTemperature: any(named: 'maximumTemperature'),
          precipitationProbability: any(named: 'precipitationProbability'),
          maximumWindSpeed: any(named: 'maximumWindSpeed'),
        ),
      );
    },
  );

  blocTest<CityDetailsCubit, CityDetailsState>(
    'change d’activité et recalcule toutes les recommandations',
    setUp: () {
      stubForecastSuccess();
      stubRecommendations([
        recommendedResult,
        possibleResult,
        possibleResult,
        recommendedResult,
      ]);
    },
    build: buildCubit,
    act: (cubit) async {
      await cubit.loadForecast(latitude: 45.75, longitude: 4.85);
      cubit.selectActivity(ActivityEnum.running);
    },
    skip: 2,
    expect: () => [
      isA<CityDetailsSuccess>()
          .having(
            (state) => state.selectedActivity,
            'selectedActivity',
            ActivityEnum.running,
          )
          .having((state) => state.recommendations, 'recommendations', [
            possibleResult,
            recommendedResult,
          ]),
    ],
    verify: (_) {
      verify(
        () => recommendationService.evaluate(
          activity: ActivityEnum.running,
          minimumTemperature: any(named: 'minimumTemperature'),
          maximumTemperature: any(named: 'maximumTemperature'),
          precipitationProbability: any(named: 'precipitationProbability'),
          maximumWindSpeed: any(named: 'maximumWindSpeed'),
        ),
      ).called(2);
    },
  );

  blocTest<CityDetailsCubit, CityDetailsState>(
    'ne fait rien lorsque l’activité choisie est déjà sélectionnée',
    setUp: () {
      stubForecastSuccess();
      stubRecommendations([recommendedResult, possibleResult]);
    },
    build: buildCubit,
    act: (cubit) async {
      await cubit.loadForecast(latitude: 45.75, longitude: 4.85);
      cubit.selectActivity(ActivityEnum.walking);
    },
    skip: 2,
    expect: () => <CityDetailsState>[],
  );

  blocTest<CityDetailsCubit, CityDetailsState>(
    'ignore la sélection d’activité hors de l’état success',
    build: buildCubit,
    act: (cubit) => cubit.selectActivity(ActivityEnum.picnic),
    expect: () => <CityDetailsState>[],
    verify: (_) {
      verifyNever(
        () => recommendationService.evaluate(
          activity: any(named: 'activity'),
          minimumTemperature: any(named: 'minimumTemperature'),
          maximumTemperature: any(named: 'maximumTemperature'),
          precipitationProbability: any(named: 'precipitationProbability'),
          maximumWindSpeed: any(named: 'maximumWindSpeed'),
        ),
      );
    },
  );
}
