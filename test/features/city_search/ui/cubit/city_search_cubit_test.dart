import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';

final class MockCitySearchRepository extends Mock
    implements CitySearchRepository {}

final class FakeCancelToken extends Fake implements CancelToken {}

void main() {
  late MockCitySearchRepository repository;

  const lyon = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
    countryCode: 'FR',
    timezone: 'Europe/Paris',
  );

  const paris = City(
    id: 2988507,
    name: 'Paris',
    latitude: 48.8534,
    longitude: 2.3488,
    country: 'France',
    region: 'Île-de-France',
    countryCode: 'FR',
    timezone: 'Europe/Paris',
  );

  setUpAll(() {
    registerFallbackValue(FakeCancelToken());
  });

  setUp(() {
    repository = MockCitySearchRepository();
  });

  // Tests
  test('initial state is CitySearchInitial', () async {
    final cubit = CitySearchCubit(repository: repository);

    expect(cubit.state, const CitySearchInitial());

    await cubit.close();
  });

  blocTest<CitySearchCubit, CitySearchState>(
    'does not call repository when query has fewer than 3 characters',
    build: () => CitySearchCubit(repository: repository),
    act: (cubit) => cubit.onQueryChanged('Ly'),
    expect: () => const [CitySearchInitial()],
    verify: (_) {
      verifyNever(
        () => repository.searchCities(
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      );
    },
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'emits loading then success when cities are found',
    setUp: () {
      when(
        () => repository.searchCities(
          'Lyon',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => const [lyon]);
    },
    build: () => CitySearchCubit(repository: repository),
    act: (cubit) => cubit.searchImmediately('Lyon'),
    expect: () => const [
      CitySearchLoading(),
      CitySearchSuccess(cities: [lyon]),
    ],
    verify: (_) {
      verify(
        () => repository.searchCities(
          'Lyon',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    },
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'emits loading then empty when no city is found',
    setUp: () {
      when(
        () => repository.searchCities(
          'Inconnue',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => const []);
    },
    build: () => CitySearchCubit(repository: repository),
    act: (cubit) => cubit.searchImmediately('Inconnue'),
    expect: () => const [CitySearchLoading(), CitySearchEmpty()],
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'emits loading then failure when repository throws a connection error',
    setUp: () {
      when(
        () => repository.searchCities(
          'Lyon',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        const ApiException(
          type: ApiExceptionType.connection,
          message: 'No connection',
        ),
      );
    },
    build: () => CitySearchCubit(repository: repository),
    act: (cubit) => cubit.searchImmediately('Lyon'),
    expect: () => const [
      CitySearchLoading(),
      CitySearchFailure(message: 'Vérifie ta connexion internet.'),
    ],
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'only searches the latest query after debounce',
    setUp: () {
      when(
        () => repository.searchCities(
          'Lyon',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => const [lyon]);
    },
    build: () => CitySearchCubit(
      repository: repository,
      debounceDuration: const Duration(milliseconds: 20),
    ),
    act: (cubit) async {
      cubit.onQueryChanged('Lyo');

      await Future<void>.delayed(const Duration(milliseconds: 5));

      cubit.onQueryChanged('Lyon');
    },
    wait: const Duration(milliseconds: 50),
    expect: () => const [
      CitySearchLoading(),
      CitySearchSuccess(cities: [lyon]),
    ],
    verify: (_) {
      verifyNever(
        () => repository.searchCities(
          'Lyo',
          cancelToken: any(named: 'cancelToken'),
        ),
      );

      verify(
        () => repository.searchCities(
          'Lyon',
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    },
  );

  test('cancels the previous request when a new search starts', () async {
    final firstCompleter = Completer<List<City>>();

    CancelToken? firstToken;
    CancelToken? secondToken;

    when(
      () => repository.searchCities(
        'Lyon',
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer((invocation) {
      firstToken = invocation.namedArguments[#cancelToken] as CancelToken;

      return firstCompleter.future;
    });

    when(
      () => repository.searchCities(
        'Paris',
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer((invocation) async {
      secondToken = invocation.namedArguments[#cancelToken] as CancelToken;

      return const [paris];
    });

    final cubit = CitySearchCubit(repository: repository);

    final firstSearch = cubit.searchImmediately('Lyon');

    await Future<void>.delayed(Duration.zero);

    await cubit.searchImmediately('Paris');

    expect(firstToken, isNotNull);
    expect(firstToken!.isCancelled, isTrue);

    expect(secondToken, isNotNull);
    expect(secondToken!.isCancelled, isFalse);

    firstCompleter.complete(const [lyon]);
    await firstSearch;

    expect(cubit.state, const CitySearchSuccess(cities: [paris]));

    await cubit.close();
  });

  blocTest<CitySearchCubit, CitySearchState>(
    'emits history when saved cities exist',
    build: () {
      when(() => repository.getSearchHistory()).thenAnswer((_) async => [lyon]);

      return CitySearchCubit(repository: repository);
    },
    act: (cubit) => cubit.loadHistory(),
    expect: () => [
      const CitySearchHistory([lyon]),
    ],
    verify: (_) {
      verify(() => repository.getSearchHistory()).called(1);
    },
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'emits initial when history is empty',
    build: () {
      when(() => repository.getSearchHistory()).thenAnswer((_) async => []);

      return CitySearchCubit(repository: repository);
    },
    act: (cubit) => cubit.loadHistory(),
    expect: () => [const CitySearchInitial()],
  );

  blocTest<CitySearchCubit, CitySearchState>(
    'removes one city from history',
    seed: () => const CitySearchHistory([lyon, paris]),
    build: () {
      when(
        () => repository.removeCityFromHistory(lyon),
      ).thenAnswer((_) async {});

      return CitySearchCubit(repository: repository);
    },
    act: (cubit) => cubit.removeCityFromHistory(lyon),
    expect: () => [
      const CitySearchHistory([paris]),
    ],
  );
}
