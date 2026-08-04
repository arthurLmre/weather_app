import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/models/city_dto.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository_impl.dart';

final class MockCitySearchDataSource extends Mock
    implements CitySearchDataSource {}

void main() {
  late MockCitySearchDataSource dataSource;
  late CitySearchRepositoryImpl repository;

  setUp(() {
    dataSource = MockCitySearchDataSource();

    repository = CitySearchRepositoryImpl(dataSource: dataSource);
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
      () => dataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).thenAnswer((_) async => const [dto]);

    final result = await repository.searchCities(
      'Lyon',
      cancelToken: cancelToken,
    );

    expect(result, hasLength(1));
    expect(result.first.name, 'Lyon');
    expect(result.first.region, 'Auvergne-Rhône-Alpes');

    verify(
      () => dataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).called(1);
  });

  test('propagates data source exceptions', () async {
    final cancelToken = CancelToken();

    const exception = ApiException(
      type: ApiExceptionType.connection,
      message: 'No connection',
    );

    when(
      () => dataSource.searchCities('Lyon', cancelToken: cancelToken),
    ).thenThrow(exception);

    expect(
      () => repository.searchCities('Lyon', cancelToken: cancelToken),
      throwsA(same(exception)),
    );
  });
}
