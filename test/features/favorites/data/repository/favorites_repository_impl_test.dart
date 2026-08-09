import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/datasources/favorites_data_source.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository_impl.dart';

final class MockFavoritesLocalDataSource extends Mock
    implements FavoritesLocalDataSource {}

void main() {
  late MockFavoritesLocalDataSource localDataSource;
  late FavoritesRepositoryImpl repository;

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
    registerFallbackValue(<City>[]);
  });

  setUp(() {
    localDataSource = MockFavoritesLocalDataSource();
    repository = FavoritesRepositoryImpl(localDataSource: localDataSource);
  });

  group('getFavorites', () {
    test('retourne les favoris fournis par la source locale', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon]);

      final result = await repository.getFavorites();

      expect(result, [lyon]);
      verify(() => localDataSource.getFavorites()).called(1);
    });
  });

  group('addFavorite', () {
    test('ajoute la ville à la fin des favoris existants', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon]);
      when(() => localDataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.addFavorite(paris);

      verify(() => localDataSource.saveFavorites([lyon, paris])).called(1);
    });

    test('n’enregistre rien lorsque la ville existe déjà', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon]);

      await repository.addFavorite(lyon);

      verifyNever(() => localDataSource.saveFavorites(any()));
    });

    test(
      'détecte un doublon par identifiant, même si les autres données diffèrent',
      () async {
        const renamedLyon = City(
          id: 2996944,
          name: 'Lyon renommée',
          latitude: 0,
          longitude: 0,
          country: 'France',
          region: 'Test',
        );

        when(
          () => localDataSource.getFavorites(),
        ).thenAnswer((_) async => [lyon]);

        await repository.addFavorite(renamedLyon);

        verifyNever(() => localDataSource.saveFavorites(any()));
      },
    );
  });

  group('removeFavorite', () {
    test('supprime uniquement la ville ayant le même identifiant', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon, paris]);
      when(() => localDataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.removeFavorite(lyon);

      verify(() => localDataSource.saveFavorites([paris])).called(1);
    });

    test(
      'réenregistre la liste inchangée lorsque la ville est absente',
      () async {
        when(
          () => localDataSource.getFavorites(),
        ).thenAnswer((_) async => [lyon]);
        when(
          () => localDataSource.saveFavorites(any()),
        ).thenAnswer((_) async {});

        await repository.removeFavorite(paris);

        verify(() => localDataSource.saveFavorites([lyon])).called(1);
      },
    );
  });

  group('toggleFavorite', () {
    test('ajoute la ville lorsqu’elle n’est pas favorite', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon]);
      when(() => localDataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.toggleFavorite(paris);

      verify(() => localDataSource.saveFavorites([lyon, paris])).called(1);
    });

    test('retire la ville lorsqu’elle est déjà favorite', () async {
      when(
        () => localDataSource.getFavorites(),
      ).thenAnswer((_) async => [lyon, paris]);
      when(() => localDataSource.saveFavorites(any())).thenAnswer((_) async {});

      await repository.toggleFavorite(lyon);

      verify(() => localDataSource.saveFavorites([paris])).called(1);
    });
  });
}
