import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_end_points.dart';

final class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient apiClient;
  late CitySearchDataSourceImpl dataSource;

  setUp(() {
    apiClient = MockApiClient();

    dataSource = CitySearchDataSourceImpl(apiClient: apiClient);
  });

  test('calls API and parses returned cities', () async {
    final cancelToken = CancelToken();

    when(
      () => apiClient.get(
        CitySearchEndPoints.search,
        queryParameters: any(named: 'queryParameters'),
        cancelToken: cancelToken,
      ),
    ).thenAnswer(
      (_) async => {
        'results': [
          {
            'id': 2996944,
            'name': 'Lyon',
            'latitude': 45.7485,
            'longitude': 4.8467,
            'country': 'France',
            'admin1': 'Auvergne-Rhône-Alpes',
            'country_code': 'FR',
            'timezone': 'Europe/Paris',
          },
        ],
      },
    );

    final result = await dataSource.searchCities(
      'Lyon',
      cancelToken: cancelToken,
    );

    expect(result, hasLength(1));
    expect(result.first.name, 'Lyon');
    expect(result.first.region, 'Auvergne-Rhône-Alpes');
    expect(result.first.countryCode, 'FR');

    final queryParameters =
        verify(
              () => apiClient.get(
                CitySearchEndPoints.search,
                queryParameters: captureAny(named: 'queryParameters'),
                cancelToken: cancelToken,
              ),
            ).captured.single
            as Map<String, dynamic>;

    expect(queryParameters['name'], 'Lyon');
    expect(queryParameters['count'], 10);
    expect(queryParameters['language'], 'fr');
    expect(queryParameters['format'], 'json');
  });

  test('returns an empty list when results is absent', () async {
    when(
      () => apiClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer((_) async => {});

    final result = await dataSource.searchCities(
      'Lyon',
      cancelToken: CancelToken(),
    );

    expect(result, isEmpty);
  });

  test('throws invalidData when results is not a list', () async {
    when(
      () => apiClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer((_) async => {'results': 'invalid'});

    expect(
      () => dataSource.searchCities('Lyon', cancelToken: CancelToken()),
      throwsA(
        isA<ApiException>().having(
          (error) => error.type,
          'type',
          ApiExceptionType.invalidData,
        ),
      ),
    );
  });
}
