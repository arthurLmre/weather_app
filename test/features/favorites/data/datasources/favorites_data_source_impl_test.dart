import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/storage/local_storage.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/datasources/favorites_data_source_impl.dart';

final class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockLocalStorage localStorage;
  late FavoritesLocalDataSourceImpl dataSource;

  const lyon = City(
    id: 2996944,
    name: 'Lyon',
    latitude: 45.7485,
    longitude: 4.8467,
    country: 'France',
    region: 'Auvergne-Rhône-Alpes',
  );

  const paris = City(
    id: 2988507,
    name: 'Paris',
    latitude: 48.8534,
    longitude: 2.3488,
    country: 'France',
    region: 'Île-de-France',
  );

  setUpAll(() {
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    localStorage = MockLocalStorage();
    dataSource = FavoritesLocalDataSourceImpl(localStorage: localStorage);
  });

  group('getFavorites', () {
    test(
      'retourne une liste vide lorsque le stockage ne contient rien',
      () async {
        when(
          () => localStorage.getStringList('favorite_cities'),
        ).thenAnswer((_) async => null);

        final result = await dataSource.getFavorites();

        expect(result, isEmpty);
        verify(() => localStorage.getStringList('favorite_cities')).called(1);
      },
    );

    test('désérialise les villes enregistrées', () async {
      when(() => localStorage.getStringList('favorite_cities')).thenAnswer(
        (_) async => [jsonEncode(lyon.toJson()), jsonEncode(paris.toJson())],
      );

      final result = await dataSource.getFavorites();

      expect(result, [lyon, paris]);
    });

    test(
      'ignore les entrées JSON invalides et conserve les entrées valides',
      () async {
        when(() => localStorage.getStringList('favorite_cities')).thenAnswer(
          (_) async => [
            jsonEncode(lyon.toJson()),
            '{json invalide',
            jsonEncode(<String, dynamic>{'unexpected': true}),
            jsonEncode(paris.toJson()),
          ],
        );

        final result = await dataSource.getFavorites();

        expect(result, [lyon, paris]);
      },
    );
  });

  group('saveFavorites', () {
    test('sérialise puis enregistre toutes les villes', () async {
      when(
        () => localStorage.setStringList(
          key: any(named: 'key'),
          values: any(named: 'values'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.saveFavorites([lyon, paris]);

      final captured = verify(
        () => localStorage.setStringList(
          key: captureAny(named: 'key'),
          values: captureAny(named: 'values'),
        ),
      ).captured;

      expect(captured.first, 'favorite_cities');

      final encodedCities = captured.last as List<String>;
      expect(encodedCities.map(jsonDecode), [lyon.toJson(), paris.toJson()]);
    });

    test('enregistre une liste vide lorsqu’il n’y a aucun favori', () async {
      when(
        () => localStorage.setStringList(
          key: any(named: 'key'),
          values: any(named: 'values'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.saveFavorites([]);

      verify(
        () => localStorage.setStringList(
          key: 'favorite_cities',
          values: const <String>[],
        ),
      ).called(1);
    });
  });
}
