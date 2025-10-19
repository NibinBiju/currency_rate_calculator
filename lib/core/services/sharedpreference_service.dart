import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String _listKey = 'savedStringList';

  Future<bool> saveStringList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(_listKey, list);
  }

  Future<List<String>> getStringList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_listKey) ?? <String>[];
  }
}
