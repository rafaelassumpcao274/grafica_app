import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primaryDark = Color(0xFF1A1F3A);
  static const primaryBlue = Color(0xFF4A5BF4);
  static const accentPurple = Color(0xFF7B68EE);
  static const accentPink = Color(0xFFE86AF0);
  static const lightGray = Color(0xFFF5F6FA);
  static const mediumGray = Color(0xFFE1E4EB);
  static const textDark = Color(0xFF1E2235);
  static const textGray = Color(0xFF6B7280);
  static const white = Color(0xFFFFFFFF);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const cardBackground = Color(0xFFFBFBFD);
}



ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.lightGray,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryBlue,
    secondary: AppColors.accentPurple,
    surface: AppColors.white,
    error: AppColors.error,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDark, letterSpacing: -0.5),
    displayMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark),
    headlineMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textDark),
    titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark),
    titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
    titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
    bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textDark),
    bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textGray),
    bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textGray),
    labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark),
    labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textGray),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark),
    iconTheme: IconThemeData(color: AppColors.textDark),
  ),
);

ThemeData get darkTheme => lightTheme;
