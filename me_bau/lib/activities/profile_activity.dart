import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../main.dart'; // Import main.dart to access themeModeNotifier

class ProfileActivity {
  final BuildContext context;
  final ProfileViewModel viewModel;
  final HomeViewModel homeViewModel;

  ProfileActivity(this.context, this.viewModel, this.homeViewModel);

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
    final TextEditingController nameController = TextEditingController(text: viewModel.userName);
    final TextEditingController ageController = TextEditingController(text: viewModel.userAge?.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa thông tin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên của bạn'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Tuổi của bạn'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              final newName = nameController.text.trim();
              final newAge = int.tryParse(ageController.text.trim());

              if (newName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tên không được để trống')),
                );
                return;
              }
              if (newAge == null || newAge <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tuổi không hợp lệ')),
                );
                return;
              }

              await viewModel.updateUserInfo(newName, newAge);
              await homeViewModel.loadData(); // Refresh home screen
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void navigateToDueDateManagement() {
    showDatePicker(
      context: context,
      initialDate: homeViewModel.dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((pickedDate) async {
      if (pickedDate != null) {
        await homeViewModel.saveDueDate(pickedDate);
        // No need to call homeViewModel.loadData() here, saveDueDate already does it
      }
    });
  }

  void navigateToNotificationsSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cài đặt thông báo'),
        content: const Text('Các tùy chọn thông báo sẽ được hiển thị tại đây.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        ],
      ),
    );
  }

  void navigateToLanguageSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cài đặt ngôn ngữ'),
        content: const Text('Các tùy chọn ngôn ngữ sẽ được hiển thị tại đây.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        ],
      ),
    );
  }

  void navigateToThemeSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cài đặt giao diện'),
        content: const Text('Các tùy chọn giao diện (sáng/tối) sẽ được hiển thị tại đây.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        ],
      ),
    );
  }

  void toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    ThemeMode currentMode = themeModeNotifier.value;
    ThemeMode newMode;

    if (currentMode == ThemeMode.light) {
      newMode = ThemeMode.dark;
    } else {
      newMode = ThemeMode.light;
    }

    themeModeNotifier.value = newMode;
    await prefs.setString('themeMode', newMode == ThemeMode.light ? 'light' : 'dark');
  }

  void navigateToHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trợ giúp'),
        content: const Text('Nội dung trợ giúp sẽ được hiển thị tại đây.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        ],
      ),
    );
  }

  void navigateToFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gửi phản hồi'),
        content: const Text('Biểu mẫu gửi phản hồi sẽ được hiển thị tại đây.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        ],
      ),
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
