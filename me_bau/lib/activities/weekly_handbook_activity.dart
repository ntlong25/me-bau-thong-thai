import 'package:flutter/material.dart';
import '../viewmodels/weekly_handbook_viewmodel.dart';

class WeeklyHandbookActivity {
  final BuildContext context;
  final WeeklyHandbookViewModel viewModel;

  WeeklyHandbookActivity(this.context, this.viewModel);

  void initialize() {
    // Initialize with the initial week
  }

  void navigateToWeek(int targetWeek) {
    if (targetWeek < 1 || targetWeek > 40) return;
    viewModel.setCurrentWeek(targetWeek);
  }

  void navigateToHome() {
    Navigator.pop(context);
  }

  bool canNavigateToPreviousWeek() {
    return viewModel.currentWeek > 1;
  }

  bool canNavigateToNextWeek() {
    return viewModel.currentWeek < 40;
  }

  bool shouldShowHomeButton() {
    return viewModel.currentWeekData == null &&
        viewModel.currentWeek <= 1 &&
        viewModel.currentWeek >= 40;
  }
}
