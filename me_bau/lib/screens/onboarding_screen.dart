import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../activities/onboarding_activity.dart';
import '../widgets/form_components.dart';
import '../widgets/app_components.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late OnboardingViewModel _viewModel;
  late OnboardingActivity _activity;

  @override
  void initState() {
    super.initState();
    _viewModel = OnboardingViewModel();
    _activity = OnboardingActivity(context, _viewModel);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<OnboardingViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header
                      Icon(Icons.favorite,
                          size: 80, color: colorScheme.primary),
                      const SizedBox(height: 24),

                      Text(
                        'Chào mừng bạn!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      Text(
                        'Hãy cho chúng tôi biết một chút về bạn',
                        style: TextStyle(
                            fontSize: 16, color: colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Name field
                      CustomTextFormField(
                        labelText: 'Tên của bạn',
                        hintText: 'Nhập tên của bạn',
                        prefixIcon: Icons.person,
                        controller: _nameController,
                        onChanged: (value) => _activity.updateUserName(value),
                        validator: (value) => _activity.validateName(value),
                      ),
                      const SizedBox(height: 32),

                      // Age picker
                      CustomNumberPickerContainer(
                        title: 'Tuổi của bạn',
                        icon: Icons.cake,
                        value: viewModel.userAge,
                        minValue: 13,
                        maxValue: 100,
                        onChanged: (value) => _activity.updateUserAge(value),
                      ),
                      const SizedBox(height: 48),

                      // Submit button
                      PrimaryButton(
                        text: 'Bắt đầu hành trình',
                        onPressed: () => _activity.saveUserInfo(),
                        isLoading: viewModel.isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Skip option
                      TextButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => _activity.skipOnboarding(),
                        child: Text(
                          'Bỏ qua (Có thể cập nhật sau)',
                          style: TextStyle(
                              color: colorScheme.onSurfaceVariant, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
