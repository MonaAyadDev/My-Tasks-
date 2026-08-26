import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required String value,
  }) async {
    return await _preferences.setString(key, value);
  }

  static String? getData({required String key}) {
    return _preferences.getString(key);
  }
}
