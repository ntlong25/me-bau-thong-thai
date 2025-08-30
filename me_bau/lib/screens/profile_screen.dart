import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../activities/profile_activity.dart';

class ProfileScreen extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final ProfileViewModel profileViewModel;
  const ProfileScreen({super.key, required this.homeViewModel, required this.profileViewModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileActivity _activity;

  @override
  void initState() {
    super.initState();
    _activity = ProfileActivity(context, widget.profileViewModel, widget.homeViewModel);
    _activity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Consumer<ProfileViewModel>(
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
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      viewModel.displayName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    if (viewModel.userAge != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Tuổi: ${viewModel.userAge}',
                        style: TextStyle(
                            fontSize: 16, color: colorScheme.onSurfaceVariant),
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
            ],
          ),
        );
      },
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
                color: colorScheme.onSurface.withAlpha(25),
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
