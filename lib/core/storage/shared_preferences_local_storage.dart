import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/storage/local_storage.dart';

final class SharedPreferencesLocalStorage implements LocalStorage {
  SharedPreferencesLocalStorage(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> getString(String key) {
    return _preferences.getString(key);
  }

  @override
  Future<List<String>?> getStringList(String key) {
    return _preferences.getStringList(key);
  }

  @override
  Future<void> setString({required String key, required String value}) {
    return _preferences.setString(key, value);
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> values,
  }) {
    return _preferences.setStringList(key, values);
  }

  @override
  Future<void> remove(String key) {
    return _preferences.remove(key);
  }
}
