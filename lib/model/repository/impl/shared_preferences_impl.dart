import 'package:cuk/model/interface/shared_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl implements SharedPreferencesInterface {
  late SharedPreferences _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> readString(String key) async {
    String? value = _prefs.getString(key) ?? '-';
    return value;
  }

  @override
  Future remove(String key) {
    throw UnimplementedError();
  }

  @override
  Future writeString(String key, String value) {
    throw UnimplementedError();
  }
}
