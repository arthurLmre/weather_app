abstract interface class LocalStorage {
  Future<String?> getString(String key);

  Future<List<String>?> getStringList(String key);

  Future<void> setString({required String key, required String value});

  Future<void> setStringList({
    required String key,
    required List<String> values,
  });

  Future<void> remove(String key);
}
