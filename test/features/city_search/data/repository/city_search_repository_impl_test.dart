import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source.dart';
import 'package:weather_app/features/city_search/data/models/city_dto.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository_impl.dart';

final class MockCitySearchDataSource extends Mock
    implements CitySearchDataSource {}

final class MockSearchHistoryLocalDataSource extends Mock
    implements SearchHistoryLocalDataSource {}

void main() {
  late MockCitySearchDataSource citySearchDataSource;
  late MockSearchHistoryLocalDataSource historyLocalDataSource;
  late CitySearchRepositoryImpl repository;

  setUp(() {
    citySearchDataSource = MockCitySearchDataSource();
    historyLocalDataSource = MockSearchHistoryLocalDataSource();

    repository = CitySearchRepositoryImpl(
      citySearchDataSource: citySearchDataSource,
      historyLocalDataSource: historyLocalDataSource,
    );
  });

  test('converts CityDto into City', () async {
    const dto = CityDto(
      id: 2996944,
      name: 'Lyon',
      latitude: 45.7485,
      longitude: 4.8467,
      country: 'France',
      region: 'Auvergne-Rhône-Alpes',
    );

    final cancelToken = CancelToken();

    when(
      () => citySearchDataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).thenAnswer((_) async => const [dto]);

    final result = await repository.searchCities(
      'Lyon',
      cancelToken: cancelToken,
    );

    expect(result, hasLength(1));
    expect(result.first.name, 'Lyon');
    expect(result.first.region, 'Auvergne-Rhône-Alpes');

    verify(
      () => citySearchDataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).called(1);
  });

  test('propagates data source exceptions', () async {
    final cancelToken = CancelToken();

    const exception = ApiException(
      type: ApiExceptionType.connection,
      message: 'No connection',
    );

    when(
      () => citySearchDataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).thenThrow(exception);

    expect(
      () => repository.searchCities('Lyon', cancelToken: cancelToken),
      throwsA(same(exception)),
    );
  });
}
