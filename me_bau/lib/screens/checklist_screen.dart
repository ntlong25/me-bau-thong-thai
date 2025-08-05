import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/checklist_viewmodel.dart';
import '../activities/checklist_activity.dart';
import '../widgets/app_components.dart';
import '../widgets/form_components.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late ChecklistViewModel _viewModel;
  late ChecklistActivity _activity;

  @override
  void initState() {
    super.initState();
    _viewModel = ChecklistViewModel();
    _activity = ChecklistActivity(context, _viewModel);
    _activity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ChecklistViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            body: viewModel.checklistItems.isEmpty
                ? const EmptyStateWidget(
                    title: 'Checklist của bạn trống',
                    subtitle: 'Thêm các mục cần chuẩn bị!',
                    icon: Icons.checklist,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: viewModel.checklistItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.checklistItems[index];
                      return CustomCheckboxListTile(
                        title: item.name,
                        value: item.isCompleted,
                        onChanged: (bool? value) {
                          _activity.toggleItem(index, value);
                        },
                        trailing: TextButton.icon(
                          onPressed: () => _activity.editItemNotes(index),
                          icon: const Icon(Icons.edit, size: 18),
                          label: Text(
                            item.notes == null || item.notes!.isEmpty
                                ? 'Thêm Ghi Chú'
                                : 'Sửa Ghi Chú',
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.deepPurple,
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
