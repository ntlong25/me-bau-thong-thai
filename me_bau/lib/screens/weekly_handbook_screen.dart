import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weekly_handbook_viewmodel.dart';
import '../activities/weekly_handbook_activity.dart';

class WeeklyHandbookScreen extends StatefulWidget {
  final int initialWeek;

  const WeeklyHandbookScreen({super.key, required this.initialWeek});

  @override
  State<WeeklyHandbookScreen> createState() => _WeeklyHandbookScreenState();
}

class _WeeklyHandbookScreenState extends State<WeeklyHandbookScreen>
    with TickerProviderStateMixin {
  late WeeklyHandbookViewModel _viewModel;
  late WeeklyHandbookActivity _activity;

  @override
  void initState() {
    super.initState();
    _viewModel = WeeklyHandbookViewModel();
    _activity = WeeklyHandbookActivity(context, _viewModel);

    _viewModel.setInitialWeek(widget.initialWeek);
    _viewModel.initializeAnimations(this);
    _activity.initialize();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<WeeklyHandbookViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                // Phần nội dung có thể scroll với animation
                Expanded(
                  child: AnimatedBuilder(
                    animation: viewModel.animationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: viewModel.fadeAnimation,
                        child: SlideTransition(
                          position: viewModel.slideAnimation,
                          child: ScaleTransition(
                            scale: viewModel.scaleAnimation,
                            child: !viewModel.hasData
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            size: 64,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Tuần ${viewModel.currentWeek}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme.onSurface,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Chưa có dữ liệu cho tuần này',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Vui lòng chọn tuần khác để xem thông tin',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewModel.weekTitle,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        _buildSection(
                                          'Em bé:',
                                          viewModel.babyInfo,
                                        ),
                                        const SizedBox(height: 15),
                                        _buildSection(
                                          'Mẹ:',
                                          viewModel.momInfo,
                                        ),
                                        const SizedBox(height: 15),
                                        _buildSection(
                                          'Lời khuyên:',
                                          viewModel.tipInfo,
                                        ),
                                        // Thêm padding bottom để tránh content bị che bởi buttons
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Phần buttons cố định ở bottom (luôn hiển thị)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.onSurface.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_activity.canNavigateToPreviousWeek())
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              onPressed: () => _activity
                                  .navigateToWeek(viewModel.currentWeek - 1),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.secondaryContainer,
                                foregroundColor: colorScheme.onSecondaryContainer,
                                elevation: 3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back_ios, size: 16, color: colorScheme.onSecondaryContainer),
                                  SizedBox(width: 8),
                                  Text('Tuần Trước', style: TextStyle(color: colorScheme.onSecondaryContainer)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (_activity.canNavigateToNextWeek())
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton(
                              onPressed: () => _activity
                                  .navigateToWeek(viewModel.currentWeek + 1),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: colorScheme.onPrimaryContainer,
                                elevation: 3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Tuần Sau', style: TextStyle(color: colorScheme.onPrimaryContainer)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onPrimaryContainer),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // Hiển thị button "Về trang chủ" khi không có dữ liệu và không có tuần trước/sau
                      if (_activity.shouldShowHomeButton())
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _activity.navigateToHome(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.tertiaryContainer,
                              foregroundColor: colorScheme.onTertiaryContainer,
                              elevation: 3,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home, size: 16, color: colorScheme.onTertiaryContainer),
                                SizedBox(width: 8),
                                Text('Về Trang Chủ', style: TextStyle(color: colorScheme.onTertiaryContainer)),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16, height: 1.5, color: colorScheme.onSurface),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

