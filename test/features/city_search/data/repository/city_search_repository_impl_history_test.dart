import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository_impl.dart';

final class MockCitySearchDataSource extends Mock
    implements CitySearchDataSource {}

final class MockSearchHistoryLocalDataSource extends Mock
    implements SearchHistoryLocalDataSource {}

void main() {
  late MockCitySearchDataSource citySearchDataSource;
  late MockSearchHistoryLocalDataSource historyLocalDataSource;
  late CitySearchRepositoryImpl repository;

  const lyon = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  setUp(() {
    citySearchDataSource = MockCitySearchDataSource();
    historyLocalDataSource = MockSearchHistoryLocalDataSource();

    repository = CitySearchRepositoryImpl(
      citySearchDataSource: citySearchDataSource,
      historyLocalDataSource: historyLocalDataSource,
    );
  });

  group('search history', () {
    test('returns history from the local data source', () async {
      when(
        () => historyLocalDataSource.getHistory(),
      ).thenAnswer((_) async => [lyon]);

      final result = await repository.getSearchHistory();

      expect(result, [lyon]);

      verify(() => historyLocalDataSource.getHistory()).called(1);

      verifyNoMoreInteractions(historyLocalDataSource);
      verifyZeroInteractions(citySearchDataSource);
    });

    test('adds a city to history through the local data source', () async {
      when(() => historyLocalDataSource.addCity(lyon)).thenAnswer((_) async {});

      await repository.addCityToHistory(lyon);

      verify(() => historyLocalDataSource.addCity(lyon)).called(1);

      verifyNoMoreInteractions(historyLocalDataSource);
      verifyZeroInteractions(citySearchDataSource);
    });

    test('removes a city from history through the local data source', () async {
      when(
        () => historyLocalDataSource.removeCity(lyon),
      ).thenAnswer((_) async {});

      await repository.removeCityFromHistory(lyon);

      verify(() => historyLocalDataSource.removeCity(lyon)).called(1);

      verifyNoMoreInteractions(historyLocalDataSource);
      verifyZeroInteractions(citySearchDataSource);
    });

    test('clears history through the local data source', () async {
      when(
        () => historyLocalDataSource.clearHistory(),
      ).thenAnswer((_) async {});

      await repository.clearSearchHistory();

      verify(() => historyLocalDataSource.clearHistory()).called(1);

      verifyNoMoreInteractions(historyLocalDataSource);
      verifyZeroInteractions(citySearchDataSource);
    });
  });
}
