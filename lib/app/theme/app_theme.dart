import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Colors - Primary palette from Figma
  static const Color primary50 = Color(0xFFEDF5FF);
  static const Color primary100 = Color(0xFFD6E8FF);
  static const Color primary200 = Color(0xFFADD1FF);
  static const Color primary300 = Color(0xFF84BAFF);
  static const Color primary400 = Color(0xFF5CABFF);  // Main Primary
  static const Color primary500 = Color(0xFF3391FF);
  static const Color primary600 = Color(0xFF1476F0);
  static const Color primary700 = Color(0xFF0E5AD0);
  static const Color primary800 = Color(0xFF0D4AAB);
  static const Color primary900 = Color(0xFF0B3B87);
  
  // Text Colors
  static const Color textDark = Color(0xFF333333);
  static const Color textMedium = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  // Background and surface colors
  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  
  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFFB300);
  static const Color infoColor = primary400;

  // Tema untuk Bottom Navigation Bar
  static BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary400,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
  
  // Style untuk Card Notifikasi
  static CardTheme get notificationCardTheme {
    return CardTheme(
      color: primary100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
  
  // Style untuk Alert/Dialog box
  static DialogTheme get dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      elevation: 4,
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary400,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary400,
        primary: primary400,
        secondary: primary600,
        background: backgroundColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      appBarTheme: const AppBarTheme(
        color: backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary400),
        titleTextStyle: TextStyle(
          color: primary400,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary400,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary400,
          side: const BorderSide(color: primary400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: primary400, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: primary400, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: primary600, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        hintStyle: const TextStyle(color: textLight),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDark),
        displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDark),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textDark),
        bodyLarge: TextStyle(fontSize: 16, color: textDark),
        bodyMedium: TextStyle(fontSize: 14, color: textDark),
        bodySmall: TextStyle(fontSize: 12, color: textMedium),
      ),
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      cardTheme: notificationCardTheme,
      dialogTheme: dialogTheme,
    );
  }
}