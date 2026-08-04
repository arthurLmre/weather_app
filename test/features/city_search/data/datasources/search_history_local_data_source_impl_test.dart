import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

void main() {
  late SearchHistoryLocalDataSourceImpl dataSource;

  const lyon = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    final preferences = await SharedPreferences.getInstance();

    dataSource = SearchHistoryLocalDataSourceImpl(preferences);
  });

  test('returns an empty list when history does not exist', () async {
    final result = await dataSource.getHistory();

    expect(result, isEmpty);
  });

  test('saves a city in history', () async {
    await dataSource.addCity(lyon);

    final result = await dataSource.getHistory();

    expect(result, [lyon]);
  });

  test('does not keep duplicate cities', () async {
    await dataSource.addCity(lyon);
    await dataSource.addCity(lyon);

    final result = await dataSource.getHistory();

    expect(result, hasLength(1));
    expect(result.first, lyon);
  });

  test('clears history', () async {
    await dataSource.addCity(lyon);

    await dataSource.clearHistory();

    final result = await dataSource.getHistory();

    expect(result, isEmpty);
  });
}
