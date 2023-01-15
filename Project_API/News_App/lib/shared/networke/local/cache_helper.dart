import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferenc;
  static init() async {
    // SharedPreferences.setMockInitialValues({});
    sharedPreferenc = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferenc!.setBool(key, value);
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferenc?.getBool(key);
  }
}
