import 'package:flutter/material.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeActivity {
  final HomeViewModel viewModel;
  final BuildContext context;
  final Function(int) onNavigateToTab;

  HomeActivity(this.context, this.viewModel, this.onNavigateToTab);

  // Initialize the home screen
  Future<void> initialize() async {
    await viewModel.loadData();
  }

  // Handle due date selection
  Future<void> selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 280),
      ), // 40 weeks back
      lastDate: DateTime.now().add(
        const Duration(days: 280),
      ), // 40 weeks forward
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      await viewModel.saveDueDate(picked);
      _showSuccessMessage('Đã lưu ngày dự sinh: ${_formatDate(picked)}');
    }
  }

  // Handle quick action navigation
  void navigateToQuickAction(String action) {
    switch (action) {
      case 'Cẩm Nang Tuần Thai':
        _navigateToHandbook();
        break;
      case 'Checklist Sinh':
        _navigateToChecklist();
        break;
      case 'Hồ Sơ Cá Nhân':
        _navigateToProfile();
        break;
    }
  }

  // Navigate to handbook
  void _navigateToHandbook() {
    onNavigateToTab(1); // Index for Handbook tab
  }

  // Navigate to checklist
  void _navigateToChecklist() {
    onNavigateToTab(2); // Index for Checklist tab
  }

  // Navigate to profile
  void _navigateToProfile() {
    onNavigateToTab(3); // Index for Profile tab
  }

  // Show success message
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show error message
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Format date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Get pregnancy status color
  Color getPregnancyStatusColor() {
    if (!viewModel.hasDueDate) return Colors.grey;
    if (viewModel.currentPregnancyWeek <= 0) return Colors.blue;
    if (viewModel.currentPregnancyWeek > 40) return Colors.red;
    return Colors.green;
  }

  // Get pregnancy status icon
  IconData getPregnancyStatusIcon() {
    if (!viewModel.hasDueDate) return Icons.calendar_today;
    if (viewModel.currentPregnancyWeek <= 0) return Icons.pending;
    if (viewModel.currentPregnancyWeek > 40) return Icons.warning;
    return Icons.favorite;
  }

  // Get days until due text
  String getDaysUntilDueText() {
    if (!viewModel.hasDueDate) return '';
    final days = viewModel.daysUntilDue;
    if (days > 0) {
      return 'Còn $days ngày nữa';
    } else if (days == 0) {
      return 'Hôm nay là ngày dự sinh!';
    } else {
      return 'Đã quá ${days.abs()} ngày';
    }
  }

  // Handle refresh
  Future<void> refresh() async {
    await viewModel.loadData();
  }

  // Handle settings action
  void openSettings() {
    // This will be handled by the main app screen
    // The action logic is in MainAppScreen
  }

  // Handle notifications action
  void openNotifications() {
    // This will be handled by the main app screen
    // The action logic is in MainAppScreen
  }
}
