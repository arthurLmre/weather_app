import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/storage/shared_preferences_local_storage.dart';

final class MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync {}

void main() {
  late MockSharedPreferencesAsync preferences;
  late SharedPreferencesLocalStorage localStorage;

  setUp(() {
    preferences = MockSharedPreferencesAsync();
    localStorage = SharedPreferencesLocalStorage(preferences);
  });

  group('SharedPreferencesLocalStorage', () {
    group('getString', () {
      const key = 'theme';

      test('retourne la valeur fournie par SharedPreferences', () async {
        when(() => preferences.getString(key)).thenAnswer((_) async => 'dark');

        final result = await localStorage.getString(key);

        expect(result, 'dark');
        verify(() => preferences.getString(key)).called(1);
      });

      test('retourne null lorsque la clé est absente', () async {
        when(() => preferences.getString(key)).thenAnswer((_) async => null);

        final result = await localStorage.getString(key);

        expect(result, isNull);
        verify(() => preferences.getString(key)).called(1);
      });
    });

    group('getStringList', () {
      const key = 'favorite_cities';

      test('retourne la liste fournie par SharedPreferences', () async {
        const values = ['Lyon', 'Paris'];

        when(
          () => preferences.getStringList(key),
        ).thenAnswer((_) async => values);

        final result = await localStorage.getStringList(key);

        expect(result, values);
        verify(() => preferences.getStringList(key)).called(1);
      });

      test('retourne null lorsque la clé est absente', () async {
        when(
          () => preferences.getStringList(key),
        ).thenAnswer((_) async => null);

        final result = await localStorage.getStringList(key);

        expect(result, isNull);
        verify(() => preferences.getStringList(key)).called(1);
      });
    });

    test('setString transmet la clé et la valeur', () async {
      const key = 'theme';
      const value = 'dark';

      when(() => preferences.setString(key, value)).thenAnswer((_) async {});

      await localStorage.setString(key: key, value: value);

      verify(() => preferences.setString(key, value)).called(1);
    });

    test('setStringList transmet la clé et les valeurs', () async {
      const key = 'favorite_cities';
      const values = ['Lyon', 'Paris'];

      when(
        () => preferences.setStringList(key, values),
      ).thenAnswer((_) async {});

      await localStorage.setStringList(key: key, values: values);

      verify(() => preferences.setStringList(key, values)).called(1);
    });

    test('remove transmet la clé à supprimer', () async {
      const key = 'favorite_cities';

      when(() => preferences.remove(key)).thenAnswer((_) async {});

      await localStorage.remove(key);

      verify(() => preferences.remove(key)).called(1);
    });

    test('propage les erreurs du stockage', () async {
      const key = 'theme';
      final exception = Exception('Storage unavailable');

      when(
        () => preferences.getString(key),
      ).thenAnswer((_) async => throw exception);

      await expectLater(localStorage.getString(key), throwsA(same(exception)));

      verify(() => preferences.getString(key)).called(1);
    });
  });
}
