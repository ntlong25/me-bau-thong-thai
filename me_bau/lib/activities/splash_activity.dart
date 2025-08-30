import 'package:flutter/material.dart';
import '../viewmodels/splash_viewmodel.dart';
import '../screens/onboarding_screen.dart';
import '../screens/main_app_screen.dart';
import '../services/pregnancy_service.dart';

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

    // Navigate after 2 seconds
    await Future.delayed(const Duration(milliseconds: 2000));
    if (context.mounted) {
      if (await PregnancyService.hasUserInfo()) {
        _navigateToMainApp();
      } else {
        _navigateToOnboarding();
      }
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

  void _navigateToMainApp() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainAppScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
