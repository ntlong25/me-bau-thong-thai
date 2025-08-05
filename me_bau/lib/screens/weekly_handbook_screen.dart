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
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Tuần ${viewModel.currentWeek}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Chưa có dữ liệu cho tuần này',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Vui lòng chọn tuần khác để xem thông tin',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade400,
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
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink,
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
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
                                backgroundColor: Colors.purple.shade100,
                                foregroundColor: Colors.purple.shade800,
                                elevation: 3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back_ios, size: 16),
                                  SizedBox(width: 8),
                                  Text('Tuần Trước'),
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
                                backgroundColor: Colors.pink.shade100,
                                foregroundColor: Colors.pink.shade800,
                                elevation: 3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Tuần Sau'),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 16),
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
                              backgroundColor: Colors.blue.shade100,
                              foregroundColor: Colors.blue.shade800,
                              elevation: 3,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home, size: 16),
                                SizedBox(width: 8),
                                Text('Về Trang Chủ'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
