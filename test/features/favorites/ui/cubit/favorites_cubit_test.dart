import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/favorites/data/repository/favorites_repository.dart';
import 'package:weather_app/features/favorites/ui/cubit/favorites_cubit.dart';

final class MockFavoritesRepository extends Mock
    implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository repository;
  late FavoritesCubit cubit;

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

  setUp(() {
    repository = MockFavoritesRepository();
    cubit = FavoritesCubit(repository: repository);
  });

  tearDown(() async {
    await cubit.close();
  });

  test('a FavoritesInitial comme état initial', () {
    expect(cubit.state, const FavoritesInitial());
  });

  group('loadFavorites', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'émet Loading puis Loaded avec les favoris récupérés',
      build: () {
        when(
          () => repository.getFavorites(),
        ).thenAnswer((_) async => [lyon, paris]);

        return FavoritesCubit(repository: repository);
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        const FavoritesLoading(),
        const FavoritesLoaded(favorites: [lyon, paris]),
      ],
      verify: (_) {
        verify(() => repository.getFavorites()).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'émet Loading puis Failure lorsque le repository échoue',
      build: () {
        when(
          () => repository.getFavorites(),
        ).thenThrow(Exception('storage error'));

        return FavoritesCubit(repository: repository);
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => const [
        FavoritesLoading(),
        FavoritesFailure(message: 'Impossible de charger les favoris.'),
      ],
    );
  });

  group('toggleFavorite', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'bascule le favori puis recharge la liste à jour',
      build: () {
        when(() => repository.toggleFavorite(lyon)).thenAnswer((_) async {});
        when(() => repository.getFavorites()).thenAnswer((_) async => [lyon]);

        return FavoritesCubit(repository: repository);
      },
      act: (cubit) => cubit.toggleFavorite(lyon),
      expect: () => const [
        FavoritesLoaded(favorites: [lyon]),
      ],
      verify: (_) {
        verifyInOrder([
          () => repository.toggleFavorite(lyon),
          () => repository.getFavorites(),
        ]);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'émet Failure lorsque la modification échoue',
      build: () {
        when(
          () => repository.toggleFavorite(lyon),
        ).thenThrow(Exception('storage error'));

        return FavoritesCubit(repository: repository);
      },
      act: (cubit) => cubit.toggleFavorite(lyon),
      expect: () => const [
        FavoritesFailure(message: 'Impossible de modifier les favoris.'),
      ],
      verify: (_) {
        verifyNever(() => repository.getFavorites());
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'émet Failure lorsque le rechargement après modification échoue',
      build: () {
        when(() => repository.toggleFavorite(lyon)).thenAnswer((_) async {});
        when(
          () => repository.getFavorites(),
        ).thenThrow(Exception('storage error'));

        return FavoritesCubit(repository: repository);
      },
      act: (cubit) => cubit.toggleFavorite(lyon),
      expect: () => const [
        FavoritesFailure(message: 'Impossible de modifier les favoris.'),
      ],
    );
  });

  group('isFavorite', () {
    test('retourne false lorsque l’état courant n’est pas Loaded', () {
      expect(cubit.isFavorite(lyon), isFalse);
    });

    test('retourne true lorsque la ville est présente', () async {
      when(() => repository.getFavorites()).thenAnswer((_) async => [lyon]);

      await cubit.loadFavorites();

      expect(cubit.isFavorite(lyon), isTrue);
    });

    test('retourne false lorsque la ville est absente', () async {
      when(() => repository.getFavorites()).thenAnswer((_) async => [paris]);

      await cubit.loadFavorites();

      expect(cubit.isFavorite(lyon), isFalse);
    });

    test('compare les villes par identifiant', () async {
      const renamedLyon = City(
        id: 2996944,
        name: 'Autre nom',
        latitude: 0,
        longitude: 0,
        country: 'France',
        region: 'Test',
      );

      when(() => repository.getFavorites()).thenAnswer((_) async => [lyon]);

      await cubit.loadFavorites();

      expect(cubit.isFavorite(renamedLyon), isTrue);
    });
  });
}
