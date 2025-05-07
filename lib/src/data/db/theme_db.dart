import 'package:shared_preferences/shared_preferences.dart';

class ThemeDb {
  static const String _themeKey = 'theme';
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';

  static Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  static Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'light';
  }
}
