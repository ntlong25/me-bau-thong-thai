import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Đồng Hành Thai Kỳ',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade50,
          foregroundColor: Colors.pink.shade700,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
