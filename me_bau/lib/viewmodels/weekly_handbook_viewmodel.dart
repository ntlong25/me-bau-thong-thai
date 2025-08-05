import 'package:flutter/material.dart';
import '../data/weekly_handbook_data.dart';

class WeeklyHandbookViewModel extends ChangeNotifier {
  int _currentWeek = 1;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Getters
  int get currentWeek => _currentWeek;
  Map<String, String>? get currentWeekData => weeklyHandbookData[_currentWeek];

  // Animation getters
  AnimationController get animationController => _animationController;
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;
  Animation<double> get scaleAnimation => _scaleAnimation;

  void initializeAnimations(TickerProvider vsync) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Start initial animation
    _animationController.forward();
  }

  void setCurrentWeek(int week) {
    if (week < 1 || week > 40) return;

    // Determine slide direction
    final bool isForward = week > _currentWeek;

    // Update slide animation based on direction
    _slideAnimation = Tween<Offset>(
      begin: Offset(isForward ? 0.3 : -0.3, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Reset and start animation
    _animationController.reset();
    _currentWeek = week;
    notifyListeners();
    _animationController.forward();
  }

  void setInitialWeek(int week) {
    _currentWeek = week > 0 && week <= 40 ? week : 1;
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Computed properties
  bool get hasData => currentWeekData != null;
  String get weekTitle => currentWeekData?['title'] ?? 'Thông tin tuần thai';
  String get babyInfo => currentWeekData?['baby'] ?? 'Đang cập nhật...';
  String get momInfo => currentWeekData?['mom'] ?? 'Đang cập nhật...';
  String get tipInfo => currentWeekData?['tip'] ?? 'Đang cập nhật...';
}
