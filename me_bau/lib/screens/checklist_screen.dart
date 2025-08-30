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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = ChecklistViewModel();
    _activity = ChecklistActivity(context, _viewModel);
    _activity.initialize();

    _searchController.addListener(() {
      _viewModel.filterChecklist(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ChecklistViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm checklist...',
                      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withAlpha(178)),
                      prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
                Expanded(
                  child: viewModel.filteredChecklistItems.isEmpty
                      ? EmptyStateWidget(
                          title: 'Không tìm thấy mục nào',
                          subtitle: 'Hãy thử từ khóa khác hoặc thêm mục mới!',
                          icon: Icons.search_off,
                          iconColor: colorScheme.onSurfaceVariant,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: viewModel.filteredChecklistItems.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.filteredChecklistItems[index];
                            return CustomCheckboxListTile(
                              title: item.name,
                              value: item.isCompleted,
                              onChanged: (bool? value) {
                                _activity.toggleItem(index, value);
                              },
                              trailing: TextButton.icon(
                                onPressed: () => _activity.editItemNotes(index),
                                icon: Icon(Icons.edit, size: 18, color: colorScheme.primary),
                                label: Text(
                                  item.notes == null || item.notes!.isEmpty
                                      ? 'Thêm Ghi Chú'
                                      : 'Sửa Ghi Chú',
                                  style: TextStyle(color: colorScheme.primary),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
