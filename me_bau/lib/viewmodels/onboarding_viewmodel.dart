import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  String _userName = '';
  int _userAge = 18;
  bool _isLoading = false;

  // Getters
  String get userName => _userName;
  int get userAge => _userAge;
  bool get isLoading => _isLoading;
  bool get isFormValid => _userName.trim().isNotEmpty;

  // Setters
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserAge(int age) {
    _userAge = age;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Validation
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên của bạn';
    }
    return null;
  }

  bool validateAge(int age) {
    return age >= 13 && age <= 100;
  }
}
