import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../activities/profile_activity.dart';
import '../widgets/app_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel _viewModel;
  late ProfileActivity _activity;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
    _activity = ProfileActivity(context, _viewModel);
    _activity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.pink.shade100,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.pink.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        viewModel.displayName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (viewModel.userAge != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Tuổi: ${viewModel.userAge}',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Options
                _buildProfileSection('Thông tin cá nhân', [
                  _buildProfileItem(
                    icon: Icons.person,
                    title: 'Chỉnh sửa thông tin',
                    subtitle: 'Cập nhật tên và tuổi',
                    onTap: () => _activity.navigateToEditProfile(),
                  ),
                  _buildProfileItem(
                    icon: Icons.calendar_today,
                    title: 'Ngày dự sinh',
                    subtitle: 'Quản lý ngày dự sinh',
                    onTap: () => _activity.navigateToDueDateManagement(),
                  ),
                ]),
                const SizedBox(height: 24),

                _buildProfileSection('Cài đặt', [
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
                  _buildProfileItem(
                    icon: Icons.dark_mode,
                    title: 'Giao diện',
                    subtitle: 'Chế độ sáng',
                    onTap: () => _activity.navigateToThemeSettings(),
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
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
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
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.pink.shade600, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
