import 'package:shared_preferences/shared_preferences.dart';

class PregnancyService {
  static const String _dueDateKey = 'dueDate';
  static const String _checklistKey = 'birthChecklist';
  static const String _userNameKey = 'userName';
  static const String _userAgeKey = 'userAge';
  static const String _themeModeKey = 'themeMode';

  // Tính toán tuần thai hiện tại
  static int calculatePregnancyWeek(DateTime? dueDate) {
    if (dueDate == null) {
      return 0;
    }

    // Thai kỳ thường kéo dài 40 tuần (280 ngày) tính từ ngày đầu kỳ kinh cuối.
    // Ngày dự sinh là 280 ngày sau ngày đầu kỳ kinh cuối.
    // Vậy ngày đầu kỳ kinh cuối = Ngày dự sinh - 280 ngày.
    final DateTime lastMenstrualPeriod = dueDate.subtract(
      const Duration(days: 280),
    );
    final Duration difference = DateTime.now().difference(lastMenstrualPeriod);

    // Tính tuần thai (làm tròn lên để tính cả tuần hiện tại)
    // Ví dụ: 7 ngày là tuần 1, 8 ngày là tuần 2
    int currentPregnancyWeek = (difference.inDays / 7).floor() + 1;

    // Đảm bảo tuần thai không vượt quá 40 và không nhỏ hơn 1
    if (currentPregnancyWeek > 40) {
      currentPregnancyWeek = 40;
    } else if (currentPregnancyWeek < 1) {
      currentPregnancyWeek =
          1; // Nếu ngày dự sinh ở tương lai quá xa, mặc định là tuần 1
    }

    return currentPregnancyWeek;
  }

  // Tính số ngày còn lại đến ngày dự sinh
  static int calculateDaysUntilDue(DateTime? dueDate) {
    if (dueDate == null) return 0;
    final int days = dueDate.difference(DateTime.now()).inDays;
    return days > 0 ? days : 0;
  }

  // Lưu ngày dự sinh
  static Future<void> saveDueDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dueDateKey, date.toIso8601String());
  }

  // Tải ngày dự sinh
  static Future<DateTime?> loadDueDate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dueDateString = prefs.getString(_dueDateKey);
    if (dueDateString != null) {
      return DateTime.parse(dueDateString);
    }
    return null;
  }

  // Lưu checklist
  static Future<void> saveChecklist(String checklistJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_checklistKey, checklistJson);
  }

  // Tải checklist
  static Future<String?> loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_checklistKey);
  }

  // Lưu tên người dùng
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  // Tải tên người dùng
  static Future<String?> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Lưu tuổi người dùng
  static Future<void> saveUserAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userAgeKey, age);
  }

  // Tải tuổi người dùng
  static Future<int?> loadUserAge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userAgeKey);
  }

  // Lưu chế độ chủ đề
  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode);
  }

  // Tải chế độ chủ đề
  static Future<String?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeModeKey);
  }

  // Kiểm tra xem thông tin người dùng đã tồn tại chưa
  static Future<bool> hasUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userNameKey) && prefs.containsKey(_userAgeKey);
  }

  // Xóa tất cả dữ liệu người dùng
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
    await prefs.remove(_userAgeKey);
    await prefs.remove(_dueDateKey);
    // Keep themeMode setting
  }
}
