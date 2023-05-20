import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsapp/presentation/pages/home/home.dart';
import 'package:tsapp/presentation/pages/home/home_cubit.dart';
import 'package:tsapp/presentation/pages/onboarding/onboarding.dart';
import 'package:tsapp/services/shared_preferences/shared_preferences_provider.dart';

import 'presentation/pages/choosing_prepared_style/choosing_prepared_style_cubit.dart';
import 'presentation/pages/onboarding/onboarding_cubit.dart';

class TSAPP extends StatelessWidget {
  final bool showOnboarding;
  final SharedPreferencesProvider preferencesProvider;

  const TSAPP({
    required this.preferencesProvider,
    required this.showOnboarding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (_) => ChoosingPreparedStyleCubit(),
        ),
        BlocProvider(
          create: (_) => OnBoardingCubit(
            preferencesProvider: preferencesProvider,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: showOnboarding ? const OnBoarding() : const Home(),
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.teal,
          useMaterial3: true,
        ),
      ),
    );
  }
}
