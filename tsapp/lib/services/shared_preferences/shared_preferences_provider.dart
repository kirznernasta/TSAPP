import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final _shouldShowOnboarding = 'should_show_onboarding';

  Future<SharedPreferences> get sharedPreferencesInstance =>
      SharedPreferences.getInstance();

  Future<void> saveOnboarding(bool showOnboarding) async {
    final prefs = await sharedPreferencesInstance;
    prefs.setBool(_shouldShowOnboarding, showOnboarding);
  }

  Future<bool> get onboarding async {
    final prefs = await sharedPreferencesInstance;
    return prefs.getBool(_shouldShowOnboarding) ?? true;
  }
}
