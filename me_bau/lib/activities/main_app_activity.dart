import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:me_bau/screens/profile_screen.dart';
import 'package:me_bau/screens/settings_screen.dart';
import 'package:me_bau/screens/notifications_screen.dart';
import 'package:me_bau/activities/checklist_activity.dart';
import 'package:me_bau/viewmodels/checklist_viewmodel.dart';
import 'package:me_bau/viewmodels/home_viewmodel.dart';
import 'package:me_bau/viewmodels/profile_viewmodel.dart';

class MainAppActivity {
  final BuildContext context;

  MainAppActivity(this.context);

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.pink.shade100,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.pink.shade700,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Home screen actions
  void openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
  }

  // Handbook screen actions
  void searchHandbook() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tìm kiếm Cẩm nang'),
          content: const TextField(
            decoration: InputDecoration(
              hintText: 'Nhập từ khóa tìm kiếm...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void bookmarkCurrentWeek() {
    showSnackBar('Đã đánh dấu tuần hiện tại');
  }

  void shareInformation() {
    showSnackBar('Đã chia sẻ thông tin');
  }

  // Checklist screen actions
  void addChecklistItem() {
    final checklistActivity = ChecklistActivity(context, ChecklistViewModel());
    checklistActivity.addNewItem();
  }

  void sortChecklist() {
    final checklistActivity = ChecklistActivity(context, ChecklistViewModel());
    checklistActivity.sortItems();
  }

  void filterChecklist() {
    // The search functionality is now handled directly in ChecklistScreen.
    // No action needed here.
  }

  // Profile screen actions
  void editProfile() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(homeViewModel: homeViewModel, profileViewModel: profileViewModel)),
    );
  }

  void openNotificationSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
  }

  void openHelp() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(homeViewModel: homeViewModel, profileViewModel: profileViewModel)),
    );
  }
}
