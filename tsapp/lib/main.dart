import 'package:flutter/cupertino.dart';
import 'package:tsapp/services/shared_preferences/shared_preferences_provider.dart';
import 'package:tsapp/tsapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferencesProvider provider = SharedPreferencesProvider();
  final showOnboardnig = await provider.onboarding;

  runApp(TSAPP(
    preferencesProvider: provider,
    showOnboarding: showOnboardnig,
  ));
}
