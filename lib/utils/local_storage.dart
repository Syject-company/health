import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _firstLaunchKey = 'first_launch';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool? get firstLaunch {
    return _prefs.getBool(_firstLaunchKey);
  }

  static Future<void> setFirstLaunch(bool firstLaunch) {
    return _prefs.setBool(_firstLaunchKey, firstLaunch);
  }
}
