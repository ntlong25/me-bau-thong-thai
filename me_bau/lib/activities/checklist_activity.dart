import 'package:flutter/material.dart';
import '../viewmodels/checklist_viewmodel.dart';
import '../models/checklist_item.dart';

class ChecklistActivity {
  final ChecklistViewModel viewModel;
  final BuildContext context;

  ChecklistActivity(this.context, this.viewModel);

  // Initialize the checklist screen
  Future<void> initialize() async {
    await viewModel.loadChecklist();
  }

  // Handle item toggle
  Future<void> toggleItem(int index, bool? value) async {
    await viewModel.toggleItemCompletion(index, value);
  }

  // Handle item notes edit
  Future<void> editItemNotes(int index) async {
    final TextEditingController notesController = TextEditingController(
      text: viewModel.checklistItems[index].notes,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ghi chú cho: ${viewModel.checklistItems[index].name}'),
          content: TextField(
            controller: notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Nhập ghi chú của bạn tại đây...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.updateItemNotes(index, notesController.text);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  // Handle add new item
  Future<void> addNewItem() async {
    final TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm mục mới'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Nhập tên mục checklist...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  await viewModel.addItem(nameController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  // Handle remove item
  Future<void> removeItem(int index) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text(
            'Bạn có chắc muốn xóa "${viewModel.checklistItems[index].name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.removeItem(index);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  // Handle sort items
  void sortItems() {
    viewModel.sortItems();
    _showMessage('Đã sắp xếp checklist');
  }

  // Handle filter items
  List<ChecklistItem> filterItems(String query) {
    return viewModel.getFilteredItems(query);
  }

  // Handle reset all items
  Future<void> resetAllItems() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận reset'),
          content: const Text(
            'Bạn có chắc muốn đánh dấu tất cả mục chưa hoàn thành?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.resetAllItems();
                if (context.mounted) {
                  Navigator.pop(context);
                }
                _showMessage('Đã reset tất cả mục');
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  // Handle complete all items
  Future<void> completeAllItems() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận hoàn thành'),
          content: const Text(
            'Bạn có chắc muốn đánh dấu tất cả mục đã hoàn thành?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.completeAllItems();
                if (context.mounted) {
                  Navigator.pop(context);
                }
                _showMessage('Đã hoàn thành tất cả mục');
              },
              child: const Text('Hoàn thành'),
            ),
          ],
        );
      },
    );
  }

  // Show message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Get progress indicator color
  Color getProgressColor() {
    return viewModel.progressColor;
  }

  // Get progress text
  String getProgressText() {
    return viewModel.progressText;
  }

  // Get completion percentage
  double getCompletionPercentage() {
    return viewModel.completionPercentage;
  }

  // Handle refresh
  Future<void> refresh() async {
    await viewModel.loadChecklist();
  }

  // Handle search
  void showSearchDialog() {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tìm kiếm'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Nhập từ khóa tìm kiếm...',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Filter items based on search
              final filteredItems = filterItems(value);
              // Update UI with filtered items
              _showMessage('Tìm thấy ${filteredItems.length} kết quả');
            },
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

  // Handle bulk actions
  void showBulkActionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thao tác hàng loạt'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Hoàn thành tất cả'),
                onTap: () {
                  Navigator.pop(context);
                  completeAllItems();
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Reset tất cả'),
                onTap: () {
                  Navigator.pop(context);
                  resetAllItems();
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Sắp xếp'),
                onTap: () {
                  Navigator.pop(context);
                  sortItems();
                },
              ),
            ],
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
}
