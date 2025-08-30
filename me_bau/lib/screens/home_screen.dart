import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../activities/home_activity.dart';
import '../widgets/custom_card.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateToTab;
  final HomeViewModel viewModel;
  const HomeScreen({super.key, required this.onNavigateToTab, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeActivity _activity;

  @override
  void initState() {
    super.initState();
    _activity = HomeActivity(context, widget.viewModel, widget.onNavigateToTab);
    _activity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return LoadingOverlay(
          isLoading: viewModel.isLoading,
          child: RefreshIndicator(
            onRefresh: _activity.refresh,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(viewModel),
                  const SizedBox(height: 24),
                  _buildPregnancyStatusSection(viewModel),
                  const SizedBox(height: 24),
                  _buildQuickActionsSection(viewModel),
                  const SizedBox(height: 24),
                  _buildTipsSection(viewModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeSection(HomeViewModel viewModel) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: [colorScheme.primaryContainer, colorScheme.primary.withAlpha(128)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.welcomeMessage,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Chúc bạn một ngày tốt lành!',
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildPregnancyStatusSection(HomeViewModel viewModel) {
    if (!viewModel.hasDueDate) {
      return _buildSetupCard();
    }
    return _buildPregnancyStatusCard(viewModel);
  }

  Widget _buildSetupCard() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Column(
        children: [
          Icon(Icons.calendar_today, size: 48, color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Bắt đầu theo dõi thai kỳ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Nhập ngày dự sinh để bắt đầu hành trình',
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _activity.selectDueDate(),
              icon: Icon(Icons.add, color: colorScheme.onPrimary),
              label: Text('Nhập Ngày Dự Sinh', style: TextStyle(color: colorScheme.onPrimary)),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPregnancyStatusCard(HomeViewModel viewModel) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _activity.getPregnancyStatusIcon(),
                color: _activity.getPregnancyStatusColor(),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tình trạng thai kỳ',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      viewModel.pregnancyStatusText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  'Ngày dự sinh',
                  '${viewModel.dueDate!.day}/${viewModel.dueDate!.month}/${viewModel.dueDate!.year}',
                  Icons.event,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusItem(
                  'Còn lại',
                  _activity.getDaysUntilDueText(),
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String title, String value, IconData icon) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(HomeViewModel viewModel) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thao tác nhanh',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...viewModel.quickActions.map(
          (action) => _buildQuickActionCard(action),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      onTap: () => _activity.navigateToQuickAction(action['title']),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              action['icon'] as IconData,
              color: colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  action['description'] as String,
                  style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: colorScheme.onSurfaceVariant, size: 16),
        ],
      ),
    );
  }

  Widget _buildTipsSection(HomeViewModel viewModel) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lời khuyên hôm nay',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...viewModel.tips.map((tip) => _buildTipCard(tip)),
      ],
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              tip['icon'] as IconData,
              color: colorScheme.onTertiaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip['description'] as String,
                  style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
