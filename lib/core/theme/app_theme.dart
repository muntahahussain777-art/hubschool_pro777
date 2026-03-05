import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark background palette
  static const Color bg = Color(0xFF0A0E1A);
  static const Color surface = Color(0xFF111827);
  static const Color card = Color(0xFF1A2235);
  static const Color cardBorder = Color(0xFF2D3A52);

  // Brand accent
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9C94FF);
  static const Color secondary = Color(0xFF00D4FF);
  static const Color accent = Color(0xFFFF6B6B);
  static const Color success = Color(0xFF00C48C);
  static const Color warning = Color(0xFFFFB400);
  static const Color error = Color(0xFFFF4D4F);

  // Text
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8FA3C0);
  static const Color textMuted = Color(0xFF4A5872);

  // Glassmorphism
  static const Color glass = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  // Chart colors
  static const List<Color> chart = [
    Color(0xFF6C63FF),
    Color(0xFF00D4FF),
    Color(0xFFFF6B6B),
    Color(0xFF00C48C),
    Color(0xFFFFB400),
    Color(0xFFFF63B8),
  ];
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        headlineLarge: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 24),
        headlineMedium: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 20),
        titleLarge: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18),
        titleMedium: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16),
        bodyLarge: GoogleFonts.poppins(color: AppColors.textPrimary, fontSize: 15),
        bodyMedium: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
        labelLarge: GoogleFonts.poppins(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withOpacity(0.25),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            );
          }
          return GoogleFonts.poppins(
            color: AppColors.textMuted,
            fontSize: 11,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: 24);
          }
          return const IconThemeData(color: AppColors.textMuted, size: 22);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
        hintStyle: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.cardBorder, thickness: 1),
    );
  }
}
