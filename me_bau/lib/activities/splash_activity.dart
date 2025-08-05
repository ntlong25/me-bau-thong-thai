import 'package:flutter/material.dart';
import '../viewmodels/splash_viewmodel.dart';
import '../screens/onboarding_screen.dart';

class SplashActivity {
  final BuildContext context;
  final SplashViewModel viewModel;

  SplashActivity(this.context, this.viewModel);

  void initialize(TickerProvider vsync) {
    viewModel.initializeAnimations(vsync);
    _startAnimations();
  }

  void _startAnimations() async {
    // Start fade in
    viewModel.startFadeAnimation();

    // Start scale animation after a short delay
    await Future.delayed(const Duration(milliseconds: 300));
    viewModel.startScaleAnimation();

    // Navigate to onboarding after 2 seconds
    await Future.delayed(const Duration(milliseconds: 2000));
    if (context.mounted) {
      _navigateToOnboarding();
    }
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
