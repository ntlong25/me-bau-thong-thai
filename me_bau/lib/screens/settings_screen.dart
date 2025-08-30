import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../activities/profile_activity.dart';
import '../widgets/app_components.dart';
import '../main.dart'; // Import main.dart to access themeModeNotifier

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ProfileViewModel _viewModel;
  late ProfileActivity _activity;
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    _activity = ProfileActivity(context, _viewModel, _homeViewModel);
    _activity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              title: Text('Cài đặt', style: TextStyle(color: colorScheme.onSurface)),
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection('Cài đặt chung', [
                    _buildProfileItem(
                      icon: Icons.notifications,
                      title: 'Thông báo',
                      subtitle: 'Cài đặt thông báo',
                      onTap: () => _activity.navigateToNotificationsSettings(),
                    ),
                    _buildProfileItem(
                      icon: Icons.language,
                      title: 'Ngôn ngữ',
                      subtitle: 'Tiếng Việt',
                      onTap: () => _activity.navigateToLanguageSettings(),
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.dark_mode, color: colorScheme.onPrimaryContainer, size: 20),
                      ),
                      title: Text('Giao diện', style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
                      subtitle: Text(
                        themeModeNotifier.value == ThemeMode.dark ? 'Chế độ tối' : 'Chế độ sáng',
                        style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
                      ),
                      trailing: Switch(
                        value: themeModeNotifier.value == ThemeMode.dark,
                        onChanged: (value) {
                          _activity.toggleThemeMode();
                        },
                        activeColor: colorScheme.primary,
                      ),
                      onTap: () => _activity.toggleThemeMode(),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildProfileSection('Hỗ trợ', [
                    _buildProfileItem(
                      icon: Icons.help,
                      title: 'Trợ giúp',
                      subtitle: 'Hướng dẫn sử dụng',
                      onTap: () => _activity.navigateToHelp(),
                    ),
                    _buildProfileItem(
                      icon: Icons.feedback,
                      title: 'Gửi phản hồi',
                      subtitle: 'Chia sẻ ý kiến với chúng tôi',
                      onTap: () => _activity.navigateToFeedback(),
                    ),
                    _buildProfileItem(
                      icon: Icons.info,
                      title: 'Về ứng dụng',
                      subtitle: 'Phiên bản 1.0.0',
                      onTap: () => _activity.showAppInfo(),
                    ),
                  ]),
                  const SizedBox(height: 32),
                  // Logout button
                  DangerButton(
                    text: 'Đăng xuất',
                    onPressed: () => _activity.logout(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: colorScheme.onPrimaryContainer, size: 20),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
