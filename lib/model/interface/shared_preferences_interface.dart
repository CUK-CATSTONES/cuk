abstract class SharedPreferencesInterface {
  Future<String?> readString(String key);
  Future writeString(String key, String value);
  Future remove(String key);
}
