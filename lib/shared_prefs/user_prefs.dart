import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static late SharedPreferences _prefs;
  static bool showedTutorial = true;
  static List<String> models = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getShowTutorial() {
    return _prefs.getBool('showTutorial') ?? showedTutorial;
  }

  static void setShowTutorial(bool value) {
    _prefs.setBool('showTutorial', value);
  }

  static List<String> getModels() {
    return _prefs.getStringList('models') ?? models;
  }

  static void setModels(String value) {
    models = getModels();
    models.add(value);
    _prefs.setStringList('models', models);
  }

  static void resetModels() {
    _prefs.setStringList('models', []);
  }
}
