import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:tsapp/presentation/constants/lottie_animations.dart';

import '../home/home.dart';
import 'onboarding_cubit.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  Widget _introductionScreen(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _welcomePage(),
        _selectingPage(),
        _preparedPage(),
        _sharePage(),
      ],
      done: Container(
        height: 24,
        width: 128,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.teal,
        ),
        child: const Center(
          child: Text(
            'Get started',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Century Gothiс',
            ),
          ),
        ),
      ),
      onDone: () {
        context.read<OnBoardingCubit>().setOnboarding();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        );
      },
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.teal,
      ),
      skip: Text(
        'Skip',
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontFamily: 'Century Gothiс',
        ),
      ),
      showSkipButton: true,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.teal,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  PageViewModel _welcomePage() {
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Text(
          'Welcome to the Transfer style application!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Century Gothic',
            color: Colors.grey[700],
          ),
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.only(top: 128.0),
        child: Lottie.asset(
          LottieAnimations.welcomeAnimation,
        ),
      ),
    );
  }

  PageViewModel _selectingPage() {
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Text(
          'Select an image, that will be used as style, and an another image'
          ', where the style will be transferred to.',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Century Gothiс',
            color: Colors.grey[700],
          ),
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.only(
          top: 128.0,
          right: 196,
        ),
        child: SizedBox(
          width: 160,
          height: 320,
          child: Lottie.asset(
            LottieAnimations.choosingImageAnimation,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  PageViewModel _preparedPage() {
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Text(
          'Alternatively, you can choose one of the provided photos as'
          ' the style transfer source.',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Century Gothiс',
            color: Colors.grey[700],
          ),
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.only(
          top: 128,
          right: 160,
        ),
        child: SizedBox(
          width: 160,
          height: 320,
          child: Lottie.asset(
            LottieAnimations.preparedImagesAnimation,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  PageViewModel _sharePage() {
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Text(
          'Receive the result and share with others!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Century Gothiс',
            color: Colors.grey[700],
          ),
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.only(
          top: 128,
          right: 160,
        ),
        child: SizedBox(
          width: 160,
          height: 320,
          child: Lottie.asset(
            LottieAnimations.shareAnimation,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _introductionScreen(context);
  }
}
