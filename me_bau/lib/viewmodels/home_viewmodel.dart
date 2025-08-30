import 'package:flutter/material.dart';
import '../services/pregnancy_service.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime? _dueDate;
  int _currentPregnancyWeek = 0;
  String? _userName;
  bool _isLoading = false;

  // Getters
  DateTime? get dueDate => _dueDate;
  int get currentPregnancyWeek => _currentPregnancyWeek;
  String? get userName => _userName;
  bool get isLoading => _isLoading;

  // Computed properties
  int get daysUntilDue => PregnancyService.calculateDaysUntilDue(_dueDate);
  bool get hasDueDate => _dueDate != null;
  String get pregnancyStatusText {
    if (_dueDate == null) return 'Chưa thiết lập';
    if (_currentPregnancyWeek <= 0) return 'Chưa mang thai';
    if (_currentPregnancyWeek > 40) return 'Đã quá ngày dự sinh';
    return 'Tuần $_currentPregnancyWeek';
  }

  String get welcomeMessage {
    if (_userName != null && _userName!.isNotEmpty) {
      return 'Chào mừng bạn, $_userName!';
    }
    return 'Chào mừng bạn!';
  }

  // Load data
  Future<void> loadData() async {
    _setLoading(true);
    try {
      final dueDate = await PregnancyService.loadDueDate();
      final userName = await PregnancyService.loadUserName();

      _dueDate = dueDate;
      _userName = userName;
      _calculatePregnancyWeek();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading home data: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Save due date
  Future<void> saveDueDate(DateTime date) async {
    _setLoading(true);
    try {
      await PregnancyService.saveDueDate(date);
      _dueDate = date;
      _calculatePregnancyWeek();
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving due date: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Calculate pregnancy week
  void _calculatePregnancyWeek() {
    if (_dueDate != null) {
      _currentPregnancyWeek = PregnancyService.calculatePregnancyWeek(_dueDate);
    } else {
      _currentPregnancyWeek = 0;
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Quick actions data
  List<Map<String, dynamic>> get quickActions => [
    {
      'title': 'Cẩm Nang Tuần Thai',
      'description': 'Xem thông tin chi tiết',
      'icon': Icons.book,
      'color': Colors.blue,
    },
    {
      'title': 'Checklist Sinh',
      'description': 'Quản lý danh sách chuẩn bị',
      'icon': Icons.checklist,
      'color': Colors.green,
    },
    {
      'title': 'Hồ Sơ Cá Nhân',
      'description': 'Cập nhật thông tin',
      'icon': Icons.person,
      'color': Colors.orange,
    },
  ];

  // Tips data
  List<Map<String, dynamic>> get tips => [
    {
      'title': 'Uống đủ nước',
      'description': 'Uống ít nhất 8 ly nước mỗi ngày',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Nghỉ ngơi đầy đủ',
      'description': 'Ngủ 7-9 tiếng mỗi đêm',
      'icon': Icons.bedtime,
    },
    {
      'title': 'Vận động nhẹ nhàng',
      'description': 'Đi bộ 30 phút mỗi ngày',
      'icon': Icons.directions_walk,
    },
  ];
}
