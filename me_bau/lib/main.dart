import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:me_bau/services/pregnancy_service.dart';

ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await PregnancyService.loadThemeMode();
  if (theme == 'light') {
    themeModeNotifier.value = ThemeMode.light;
  } else if (theme == 'dark') {
    themeModeNotifier.value = ThemeMode.dark;
  } else {
    themeModeNotifier.value = ThemeMode.system;
  }
  runApp(const MyApp());
}

final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.pink,
  brightness: Brightness.light,
);

final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.pink,
  brightness: Brightness.dark,
  primary: Colors.pink.shade400,
  onPrimary: Colors.black,
  primaryContainer: Colors.pink.shade900,
  onPrimaryContainer: Colors.pink.shade100,
  secondary: Colors.purple.shade400,
  onSecondary: Colors.black,
  secondaryContainer: Colors.purple.shade900,
  onSecondaryContainer: Colors.purple.shade100,
  tertiary: Colors.blue.shade400,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.blue.shade900,
  onTertiaryContainer: Colors.blue.shade100,
  error: Colors.red.shade400,
  onError: Colors.black,
  errorContainer: Colors.red.shade900,
  onErrorContainer: Colors.red.shade100,
  surface: Colors.grey.shade900,
  onSurface: Colors.white,
  surfaceContainerHighest: Colors.grey.shade800,
  onSurfaceVariant: Colors.white70,
  outline: Colors.grey.shade600,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentThemeMode, child) {
        return MaterialApp(
          title: 'Ứng dụng Đồng Hành Thai Kỳ',
          theme: ThemeData(
            colorScheme: _lightColorScheme,
            primarySwatch: Colors.pink,
            fontFamily: 'Inter',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
              backgroundColor: _lightColorScheme.surface,
              foregroundColor: _lightColorScheme.onSurface,
              elevation: 0,
            ),
            brightness: Brightness.light,
            textTheme: TextTheme(
              displayLarge: TextStyle(color: _lightColorScheme.onSurface),
              displayMedium: TextStyle(color: _lightColorScheme.onSurface),
              displaySmall: TextStyle(color: _lightColorScheme.onSurface),
              headlineLarge: TextStyle(color: _lightColorScheme.onSurface),
              headlineMedium: TextStyle(color: _lightColorScheme.onSurface),
              headlineSmall: TextStyle(color: _lightColorScheme.onSurface),
              titleLarge: TextStyle(color: _lightColorScheme.onSurface),
              titleMedium: TextStyle(color: _lightColorScheme.onSurface),
              titleSmall: TextStyle(color: _lightColorScheme.onSurface),
              bodyLarge: TextStyle(color: _lightColorScheme.onSurface),
              bodyMedium: TextStyle(color: _lightColorScheme.onSurfaceVariant),
              bodySmall: TextStyle(color: _lightColorScheme.onSurfaceVariant),
              labelLarge: TextStyle(color: _lightColorScheme.onSurface),
              labelMedium: TextStyle(color: _lightColorScheme.onSurfaceVariant),
              labelSmall: TextStyle(color: _lightColorScheme.onSurfaceVariant),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: _darkColorScheme,
            primarySwatch: Colors.pink,
            fontFamily: 'Inter',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
              backgroundColor: _darkColorScheme.surface,
              foregroundColor: _darkColorScheme.onSurface,
              elevation: 0,
            ),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: _darkColorScheme.surface,
            cardColor: _darkColorScheme.surfaceContainerHighest,
            textTheme: TextTheme(
              displayLarge: TextStyle(color: _darkColorScheme.onSurface),
              displayMedium: TextStyle(color: _darkColorScheme.onSurface),
              displaySmall: TextStyle(color: _darkColorScheme.onSurface),
              headlineLarge: TextStyle(color: _darkColorScheme.onSurface),
              headlineMedium: TextStyle(color: _darkColorScheme.onSurface),
              headlineSmall: TextStyle(color: _darkColorScheme.onSurface),
              titleLarge: TextStyle(color: _darkColorScheme.onSurface),
              titleMedium: TextStyle(color: _darkColorScheme.onSurface),
              titleSmall: TextStyle(color: _darkColorScheme.onSurface),
              bodyLarge: TextStyle(color: _darkColorScheme.onSurface),
              bodyMedium: TextStyle(color: _darkColorScheme.onSurfaceVariant),
              bodySmall: TextStyle(color: _darkColorScheme.onSurfaceVariant),
              labelLarge: TextStyle(color: _darkColorScheme.onSurface),
              labelMedium: TextStyle(color: _darkColorScheme.onSurfaceVariant),
              labelSmall: TextStyle(color: _darkColorScheme.onSurfaceVariant),
            ),
          ),
          themeMode: currentThemeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
