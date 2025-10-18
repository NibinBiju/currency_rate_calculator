import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static void saveStringValue({
    required String key,
    required String value,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static Future<String> getSaveStringValue({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String valueGot = sharedPreferences.getString(key) ?? "";
    return valueGot;
  }

  static void saveBoolValue({required String key, required bool value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  static Future<bool> getSaveBoolValue({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var valueGot = sharedPreferences.getBool(key) ?? false;
    return valueGot;
  }
}
