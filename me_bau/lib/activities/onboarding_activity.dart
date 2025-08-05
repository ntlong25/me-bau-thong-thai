import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../screens/main_app_screen.dart';

class OnboardingActivity {
  final BuildContext context;
  final OnboardingViewModel viewModel;

  OnboardingActivity(this.context, this.viewModel);

  Future<void> saveUserInfo() async {
    if (!viewModel.isFormValid) return;

    viewModel.setLoading(true);

    try {
      // Save user info to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', viewModel.userName);
      await prefs.setString('userAge', viewModel.userAge.toString());

      // Navigate to main app
      if (context.mounted) {
        _navigateToMainApp();
      }
    } catch (e) {
      if (context.mounted) {
        _showError('Có lỗi xảy ra: $e');
      }
    } finally {
      if (context.mounted) {
        viewModel.setLoading(false);
      }
    }
  }

  void skipOnboarding() {
    _navigateToMainApp();
  }

  void _navigateToMainApp() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainAppScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void updateUserName(String name) {
    viewModel.setUserName(name);
  }

  void updateUserAge(int age) {
    viewModel.setUserAge(age);
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên của bạn';
    }
    return null;
  }
}
