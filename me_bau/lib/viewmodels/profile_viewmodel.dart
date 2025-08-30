import 'package:flutter/material.dart';
import '../services/pregnancy_service.dart';

class ProfileViewModel extends ChangeNotifier {
  String? _userName;
  int? _userAge;
  bool _isLoading = true;

  // Getters
  String? get userName => _userName;
  int? get userAge => _userAge;
  bool get isLoading => _isLoading;

  // Computed properties
  String get displayName => _userName ?? 'Chưa thiết lập';
  String get displayAge =>
      _userAge != null ? '$_userAge tuổi' : 'Chưa thiết lập';
  bool get hasUserInfo => _userName != null && _userName!.isNotEmpty;

  // Load user information
  Future<void> loadUserInfo() async {
    _setLoading(true);
    try {
      _userName = await PregnancyService.loadUserName();
      _userAge = await PregnancyService.loadUserAge();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user info: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update user information
  Future<void> updateUserInfo(String name, int age) async {
    _setLoading(true);
    try {
      await PregnancyService.saveUserName(name.trim());
      await PregnancyService.saveUserAge(age);

      _userName = name.trim();
      _userAge = age;

      notifyListeners();
    } catch (e) {
      debugPrint('Error updating user info: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Clear user data (logout)
  Future<void> clearUserData() async {
    try {
      await PregnancyService.clearUserData();

      _userName = null;
      _userAge = null;

      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing user data: $e');
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Profile sections data
  List<Map<String, dynamic>> get personalInfoSection => [
    {
      'title': 'Thông tin cá nhân',
      'icon': Icons.person,
      'color': Colors.blue,
      'items': [
        {'title': 'Tên', 'value': displayName, 'icon': Icons.person_outline},
        {'title': 'Tuổi', 'value': displayAge, 'icon': Icons.cake},
      ],
    },
  ];

  List<Map<String, dynamic>> get settingsSection => [
    {
      'title': 'Cài đặt',
      'icon': Icons.settings,
      'color': Colors.grey,
      'items': [
        {
          'title': 'Thông báo',
          'subtitle': 'Quản lý thông báo',
          'icon': Icons.notifications,
          'action': 'notifications',
        },
        {
          'title': 'Ngôn ngữ',
          'subtitle': 'Tiếng Việt',
          'icon': Icons.language,
          'action': 'language',
        },
        {
          'title': 'Giao diện',
          'subtitle': 'Chế độ sáng',
          'icon': Icons.palette,
          'action': 'theme',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get supportSection => [
    {
      'title': 'Hỗ trợ',
      'icon': Icons.help,
      'color': Colors.orange,
      'items': [
        {
          'title': 'Trợ giúp',
          'subtitle': 'Hướng dẫn sử dụng',
          'icon': Icons.help_outline,
          'action': 'help',
        },
        {
          'title': 'Phản hồi',
          'subtitle': 'Gửi ý kiến',
          'icon': Icons.feedback,
          'action': 'feedback',
        },
        {
          'title': 'Về ứng dụng',
          'subtitle': 'Phiên bản 1.0.0',
          'icon': Icons.info,
          'action': 'about',
        },
      ],
    },
  ];

  // App information
  Map<String, String> get appInfo => {
    'name': 'Ứng dụng Đồng Hành Thai Kỳ',
    'version': '1.0.0',
    'build': '1',
    'description': 'Ứng dụng hỗ trợ mẹ bầu trong suốt thai kỳ',
  };

  // Handle settings actions
  void handleSettingsAction(String action) {
    switch (action) {
      case 'notifications':
        debugPrint('Open notifications settings');
        break;
      case 'language':
        debugPrint('Open language settings');
        break;
      case 'theme':
        debugPrint('Open theme settings');
        break;
      case 'help':
        debugPrint('Open help');
        break;
      case 'feedback':
        debugPrint('Open feedback');
        break;
      case 'about':
        debugPrint('Open about');
        break;
    }
  }

  // Validate user input
  String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Vui lòng nhập tên';
    }
    if (name.trim().length < 2) {
      return 'Tên phải có ít nhất 2 ký tự';
    }
    return null;
  }

  String? validateAge(String? age) {
    if (age == null || age.isEmpty) {
      return 'Vui lòng nhập tuổi';
    }
    final ageInt = int.tryParse(age);
    if (ageInt == null) {
      return 'Tuổi phải là số';
    }
    if (ageInt < 13 || ageInt > 100) {
      return 'Tuổi phải từ 13 đến 100';
    }
    return null;
  }
}
