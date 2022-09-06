import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/preferences_keys_enum.dart';

class LocaleManager {
  static final LocaleManager instance = LocaleManager._init();

  SharedPreferences? _preferences;
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static preferencesInit() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    await _preferences!.clear();
    if (_preferences != null) {
      await setBoolValue(PreferencesKeys.isFirstApp, true);
    }
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  Future<void> setIntValue(PreferencesKeys key, int value) async {
    await _preferences!.setInt(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  String? getStringValue(PreferencesKeys key) =>
      _preferences!.getString(key.toString()) ?? "";

  int? getIntValue(PreferencesKeys key) =>
      _preferences!.getInt(key.toString()) ?? -1;

  bool? getBoolValue(PreferencesKeys key) =>
      _preferences!.getBool(key.toString()) ?? false;
}
