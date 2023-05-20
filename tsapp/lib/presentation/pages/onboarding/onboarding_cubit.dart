import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/shared_preferences/shared_preferences_provider.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final SharedPreferencesProvider _preferencesProvider;

  OnBoardingCubit({
    required SharedPreferencesProvider preferencesProvider,
  })  : _preferencesProvider = preferencesProvider,
        super(OnBoardingState());

  void setOnboarding() {
    _preferencesProvider.saveOnboarding(false);
  }
}
