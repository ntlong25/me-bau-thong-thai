import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/checklist_item.dart';
import '../services/pregnancy_service.dart';

class ChecklistViewModel extends ChangeNotifier {
  List<ChecklistItem> _checklistItems = [];
  bool _isLoading = false;

  // Getters
  List<ChecklistItem> get checklistItems => _checklistItems;
  bool get isLoading => _isLoading;
  int get totalItems => _checklistItems.length;
  int get completedItems =>
      _checklistItems.where((item) => item.isCompleted).length;
  double get completionPercentage =>
      totalItems > 0 ? completedItems / totalItems : 0.0;

  // Initialize with default checklist items
  ChecklistViewModel() {
    _initializeDefaultItems();
  }

  void _initializeDefaultItems() {
    _checklistItems = [
      ChecklistItem(name: 'Chuẩn bị đồ sơ sinh'),
      ChecklistItem(name: 'Đặt lịch khám thai'),
      ChecklistItem(name: 'Chuẩn bị phòng cho bé'),
      ChecklistItem(name: 'Mua đồ dùng cần thiết'),
      ChecklistItem(name: 'Chuẩn bị giấy tờ sinh'),
      ChecklistItem(name: 'Tìm hiểu về quá trình sinh'),
      ChecklistItem(name: 'Chuẩn bị tài chính'),
      ChecklistItem(name: 'Thông báo cho gia đình'),
      ChecklistItem(name: 'Chuẩn bị đồ dùng cho mẹ'),
      ChecklistItem(name: 'Tìm hiểu về chăm sóc sau sinh'),
    ];
  }

  // Load checklist from storage
  Future<void> loadChecklist() async {
    _setLoading(true);
    try {
      final checklistJson = await PregnancyService.loadChecklist();
      if (checklistJson != null && checklistJson.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(checklistJson);
        _checklistItems = jsonList
            .map((json) => ChecklistItem.fromJson(json))
            .toList();
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading checklist: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Save checklist to storage
  Future<void> saveChecklist() async {
    try {
      final checklistJson = json.encode(
        _checklistItems.map((item) => item.toJson()).toList(),
      );
      await PregnancyService.saveChecklist(checklistJson);
    } catch (e) {
      debugPrint('Error saving checklist: $e');
    }
  }

  // Toggle item completion
  Future<void> toggleItemCompletion(int index, bool? value) async {
    if (index >= 0 && index < _checklistItems.length) {
      _checklistItems[index].isCompleted =
          value ?? !_checklistItems[index].isCompleted;
      notifyListeners();
      await saveChecklist();
    }
  }

  // Update item notes
  Future<void> updateItemNotes(int index, String notes) async {
    if (index >= 0 && index < _checklistItems.length) {
      _checklistItems[index].notes = notes.isEmpty ? null : notes;
      notifyListeners();
      await saveChecklist();
    }
  }

  // Add new item
  Future<void> addItem(String name) async {
    if (name.trim().isNotEmpty) {
      _checklistItems.add(ChecklistItem(name: name.trim()));
      notifyListeners();
      await saveChecklist();
    }
  }

  // Remove item
  Future<void> removeItem(int index) async {
    if (index >= 0 && index < _checklistItems.length) {
      _checklistItems.removeAt(index);
      notifyListeners();
      await saveChecklist();
    }
  }

  // Sort items
  void sortItems() {
    _checklistItems.sort((a, b) {
      // Sort by completion status first, then by name
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.name.compareTo(b.name);
    });
    notifyListeners();
  }

  // Filter items
  List<ChecklistItem> getFilteredItems(String query) {
    if (query.isEmpty) return _checklistItems;
    return _checklistItems
        .where(
          (item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              (item.notes?.toLowerCase().contains(query.toLowerCase()) ??
                  false),
        )
        .toList();
  }

  // Get items by completion status
  List<ChecklistItem> getItemsByStatus(bool completed) {
    return _checklistItems
        .where((item) => item.isCompleted == completed)
        .toList();
  }

  // Reset all items
  Future<void> resetAllItems() async {
    for (var item in _checklistItems) {
      item.isCompleted = false;
    }
    notifyListeners();
    await saveChecklist();
  }

  // Complete all items
  Future<void> completeAllItems() async {
    for (var item in _checklistItems) {
      item.isCompleted = true;
    }
    notifyListeners();
    await saveChecklist();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Get progress text
  String get progressText {
    if (totalItems == 0) return 'Chưa có mục nào';
    return '$completedItems/$totalItems hoàn thành';
  }

  // Get progress color
  Color get progressColor {
    if (completionPercentage >= 0.8) return Colors.green;
    if (completionPercentage >= 0.5) return Colors.orange;
    return Colors.red;
  }
}
