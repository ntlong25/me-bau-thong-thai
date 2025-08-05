import 'package:flutter/material.dart';

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
    showSnackBar('Mở cài đặt');
  }

  void openNotifications() {
    showSnackBar('Thông báo');
  }

  // Handbook screen actions
  void searchHandbook() {
    showSnackBar('Tìm kiếm trong cẩm nang');
  }

  void bookmarkCurrentWeek() {
    showSnackBar('Đánh dấu tuần hiện tại');
  }

  void shareInformation() {
    showSnackBar('Chia sẻ thông tin');
  }

  // Checklist screen actions
  void addChecklistItem() {
    showSnackBar('Thêm mục checklist mới');
  }

  void sortChecklist() {
    showSnackBar('Sắp xếp checklist');
  }

  void filterChecklist() {
    showSnackBar('Lọc checklist');
  }

  // Profile screen actions
  void editProfile() {
    showSnackBar('Chỉnh sửa hồ sơ');
  }

  void openNotificationSettings() {
    showSnackBar('Cài đặt thông báo');
  }

  void openHelp() {
    showSnackBar('Trợ giúp');
  }
}
