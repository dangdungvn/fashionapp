import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Class quản lý theme cho ứng dụng
class AppTheme {
  /// Lấy theme chính của ứng dụng
  static ThemeData getAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Kolors.kPrimary,
        primary: Kolors.kPrimary,
        secondary: Kolors.kAccent,
        tertiary: Kolors.kAccent2,
        background: Kolors.kOffWhite,
        surface: Kolors.kWhite,
        error: Kolors.kRed,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Kolors.kDark,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        displayMedium: TextStyle(
          color: Kolors.kDark,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        displaySmall: TextStyle(
          color: Kolors.kDark,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        bodyLarge: TextStyle(
          color: Kolors.kDark,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        bodyMedium: TextStyle(
          color: Kolors.kGray,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Kolors.kWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Kolors.kDark,
        ),
        titleTextStyle: TextStyle(
          color: Kolors.kDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Kolors.kPrimary,
          foregroundColor: Kolors.kWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Kolors.kWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Kolors.kWhite,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Kolors.kGrayLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Kolors.kGrayLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Kolors.kPrimary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Kolors.kRed),
        ),
        hintStyle: TextStyle(
          color: Kolors.kGray,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Kolors.kWhite,
        indicatorColor: Kolors.kPrimary.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.all(TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        )),
        iconTheme: WidgetStateProperty.all(const IconThemeData(
          size: 24,
        )),
      ),
    );
  }
}
