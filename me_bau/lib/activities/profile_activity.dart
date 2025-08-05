import 'package:flutter/material.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileActivity {
  final BuildContext context;
  final ProfileViewModel viewModel;

  ProfileActivity(this.context, this.viewModel);

  Future<void> initialize() async {
    await loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    await viewModel.loadUserInfo();
  }

  Future<void> logout() async {
    await viewModel.clearUserData();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onboarding',
        (route) => false,
      );
    }
  }

  void navigateToEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToDueDateManagement() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToNotificationsSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToLanguageSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToThemeSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void navigateToFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng đang phát triển')),
    );
  }

  void showAppInfo() {
    showAboutDialog(
      context: context,
      applicationName: 'Đồng Hành Thai Kỳ',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.favorite, color: Colors.pink),
      children: const [
        Text('Ứng dụng đồng hành cùng mẹ bầu trong suốt thai kỳ'),
      ],
    );
  }
}
