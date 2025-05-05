import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../presentation/pages/splash/splash_screen.dart';

class StudySphereApp extends StatelessWidget {
  const StudySphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudySphere',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      themeMode: ThemeMode.light,
    );
  }
}