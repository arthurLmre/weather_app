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
    for (var cityId = 0; cityId < 12; cityId++) {
      await dataSource.addCity(
        City(
          id: cityId,
          name: 'Ville $cityId',
          latitude: 45 + cityId.toDouble(),
          longitude: 4 + cityId.toDouble(),
          country: 'France',
        ),
      );
    }

    final history = await dataSource.getHistory();

    expect(history.map((city) => city.id), [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]);
  });

  test('replace existing city to first list position', () async {
    const paris = City(
      id: 2988507,
      name: 'Paris',
      latitude: 48.8566,
      longitude: 2.3522,
      country: 'France',
    );

    const marseille = City(
      id: 2995469,
      name: 'Marseille',
      latitude: 43.2965,
      longitude: 5.3698,
      country: 'France',
    );

    await dataSource.addCity(lyon);
    await dataSource.addCity(paris);
    await dataSource.addCity(marseille);

    await dataSource.addCity(lyon);

    final history = await dataSource.getHistory();

    expect(history, [lyon, marseille, paris]);
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
