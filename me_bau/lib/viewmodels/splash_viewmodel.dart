import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Getters
  AnimationController get fadeController => _fadeController;
  AnimationController get scaleController => _scaleController;
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<double> get scaleAnimation => _scaleAnimation;

  void initializeAnimations(TickerProvider vsync) {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: vsync,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  void startFadeAnimation() {
    _fadeController.forward();
  }

  void startScaleAnimation() {
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
