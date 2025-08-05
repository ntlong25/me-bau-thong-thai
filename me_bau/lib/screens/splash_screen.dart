import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/splash_viewmodel.dart';
import '../activities/splash_activity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SplashViewModel _viewModel;
  late SplashActivity _activity;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();
    _activity = SplashActivity(context, _viewModel);

    _viewModel.initializeAnimations(this);
    _activity.initialize(this);
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
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.pink.shade50,
            body: Center(
              child: AnimatedBuilder(
                animation: Listenable.merge(
                    [viewModel.fadeController, viewModel.scaleController]),
                builder: (context, child) {
                  return FadeTransition(
                    opacity: viewModel.fadeAnimation,
                    child: ScaleTransition(
                      scale: viewModel.scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Icon/Logo
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 60,
                              color: Colors.pink.shade600,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // App Name
                          Text(
                            'Đồng Hành Thai Kỳ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Tagline
                          Text(
                            'Hành trình cùng mẹ và bé',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.pink.shade500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 48),

                          // Loading indicator
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.pink.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
