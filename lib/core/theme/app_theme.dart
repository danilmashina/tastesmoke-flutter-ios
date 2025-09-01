import 'package:flutter/material.dart';

class AppTheme {
  // Цвета из Android версии
  static const Color darkBackground = Color(0xFF323234);
  static const Color cardBackground = Color(0xFF474747);
  static const Color deepDarkBackground = Color(0xFF222224);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFA1A1AA);
  static const Color accentPink = Color(0xFFD44271);
  static const Color accentBlue = Color(0xFF4285F4);
  static const Color borderGray = Color(0xFF35353F);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      
      colorScheme: const ColorScheme.dark(
        primary: accentPink,
        secondary: accentBlue,
        surface: cardBackground,
        onPrimary: primaryText,
        onSecondary: primaryText,
        onSurface: primaryText,
        outline: borderGray,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: primaryText,
        elevation: 0,
        centerTitle: true,
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardBackground,
        selectedItemColor: accentPink,
        unselectedItemColor: secondaryText,
        type: BottomNavigationBarType.fixed,
      ),
      
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentPink,
          foregroundColor: primaryText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: primaryText, fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: primaryText, fontSize: 24, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: primaryText, fontSize: 20, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: primaryText, fontSize: 16),
        bodyMedium: TextStyle(color: primaryText, fontSize: 14),
        bodySmall: TextStyle(color: secondaryText, fontSize: 12),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accentPink, width: 2),
        ),
        labelStyle: const TextStyle(color: secondaryText),
        hintStyle: const TextStyle(color: secondaryText),
      ),
    );
  }
}