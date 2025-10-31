import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeData {
  const AppThemeData({
    required this.light,
    required this.dark,
    required this.mode,
  });
  final ThemeData light;
  final ThemeData dark;
  final ThemeMode mode;
}

/// Urban Athlete Powerhouse Color Palette
class AppColors {
  // Primary Gradient Colors
  static const deepElectricBlue = Color(0xFF2D5FFF);
  static const vibrantPurple = Color(0xFF9333EA);

  // Accent Colors
  static const neonCyan = Color(0xFF06B6D4);
  static const energeticOrange = Color(0xFFFF6B35);
  static const successGreen = Color(0xFF10B981);
  static const warningAmber = Color(0xFFFBBF24);

  // Dark Theme Colors
  static const richBlack = Color(0xFF0F0F0F);
  static const deepCharcoal = Color(0xFF1A1A1A);
  static const carbonGray = Color(0xFF2A2A2A);
  static const smokeGray = Color(0xFF3F3F3F);

  // Light Theme Colors
  static const cloudWhite = Color(0xFFFAFAFA);
  static const softGray = Color(0xFFF5F5F5);
  static const lightGray = Color(0xFFE5E5E5);

  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepElectricBlue, vibrantPurple],
  );

  static const accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonCyan, deepElectricBlue],
  );

  static const successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [successGreen, Color(0xFF059669)],
  );
}

final appThemeProvider = Provider<AppThemeData>((ref) {
  // Light Theme
  final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.deepElectricBlue,
    brightness: Brightness.light,
    primary: AppColors.deepElectricBlue,
    secondary: AppColors.vibrantPurple,
    tertiary: AppColors.neonCyan,
    error: AppColors.energeticOrange,
    surface: AppColors.cloudWhite,
    surfaceContainerHighest: AppColors.softGray,
  );

  final light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: AppColors.cloudWhite,

    // Typography - Athletic and Bold
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),

    // Card Theme with Elevated Shadows
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.cloudWhite,
      foregroundColor: AppColors.richBlack,
      titleTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.richBlack,
        letterSpacing: 0,
      ),
    ),

    // Button Themes
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: lightColorScheme.outline,
          width: 2,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.softGray,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.deepElectricBlue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.energeticOrange,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.softGray,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // FAB Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.deepElectricBlue,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.lightGray,
      thickness: 1,
      space: 1,
    ),
  );

  // Dark Theme - Urban Night Training Aesthetic
  final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.deepElectricBlue,
    brightness: Brightness.dark,
    primary: AppColors.deepElectricBlue,
    secondary: AppColors.vibrantPurple,
    tertiary: AppColors.neonCyan,
    error: AppColors.energeticOrange,
    surface: AppColors.deepCharcoal,
    surfaceContainerHighest: AppColors.carbonGray,
    onSurface: AppColors.cloudWhite,
  );

  final dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: AppColors.richBlack,

    // Typography - Same as light but optimized for dark
    textTheme: light.textTheme.apply(
      bodyColor: AppColors.cloudWhite,
      displayColor: AppColors.cloudWhite,
    ),

    // Card Theme with Elevated Shadows and Glow
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.deepCharcoal,
      shadowColor: AppColors.deepElectricBlue.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppColors.smokeGray.withOpacity(0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.richBlack,
      foregroundColor: AppColors.cloudWhite,
      titleTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.cloudWhite,
        letterSpacing: 0,
      ),
    ),

    // Button Themes (inherit from light with color adjustments)
    filledButtonTheme: light.filledButtonTheme,
    elevatedButtonTheme: light.elevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: AppColors.smokeGray,
          width: 2,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.carbonGray,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.deepElectricBlue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.energeticOrange,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.cloudWhite.withOpacity(0.7),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.carbonGray,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.cloudWhite,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.smokeGray.withOpacity(0.3),
          width: 1,
        ),
      ),
    ),

    // FAB Theme with glow effect
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.deepElectricBlue,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColors.smokeGray.withOpacity(0.3),
      thickness: 1,
      space: 1,
    ),
  );

  // Later: read from settings provider
  return AppThemeData(light: light, dark: dark, mode: ThemeMode.dark);
});
