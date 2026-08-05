import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_search/data/data_sources/history/search_history_local_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

void main() {
  late InMemoryLocalStorage localStorage;
  late SearchHistoryLocalDataSourceImpl dataSource;

  const lyon = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  setUp(() {
    localStorage = InMemoryLocalStorage();
    dataSource = SearchHistoryLocalDataSourceImpl(localStorage);
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

  test('keeps only the ten most recent cities', () async {
    for (var index = 0; index < 12; index++) {
      await dataSource.addCity(
        City(
          id: index,
          name: 'Ville $index',
          latitude: 45 + index.toDouble(),
          longitude: 4 + index.toDouble(),
          country: 'France',
        ),
      );
    }

    final result = await dataSource.getHistory();

    expect(result, hasLength(10));
    expect(result.first.id, 11);
    expect(result.last.id, 2);
  });
}

/// Permet de créer un faux stockage et de concentré les tests sur SearchHistoryLocalDataSource
/// Et de ne pas sortir du périmètre pour tester le LocalStorage
final class InMemoryLocalStorage implements LocalStorage {
  final Map<String, Object> _values = {};

  @override
  Future<String?> getString(String key) async {
    return _values[key] as String?;
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final value = _values[key] as List<String>?;

    return value == null ? null : List<String>.from(value);
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    _values[key] = value;
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> values,
  }) async {
    _values[key] = List<String>.from(values);
  }

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }
}
