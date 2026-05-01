import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // Material 3
    useMaterial3: true,

    // Couleurs
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
    ),

    // Textes avec Google Fonts
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: AppTextStyles.h1
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      displayMedium: AppTextStyles.h2
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      displaySmall: AppTextStyles.h3
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      headlineLarge: AppTextStyles.h4
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      headlineMedium: AppTextStyles.h5
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      headlineSmall: AppTextStyles.h6
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      bodyLarge: AppTextStyles.bodyLarge
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: AppTextStyles.bodyMedium
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      bodySmall: AppTextStyles.bodySmall
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      labelLarge: AppTextStyles.button
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      labelMedium: AppTextStyles.label
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      labelSmall: AppTextStyles.labelSmall
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.h5.copyWith(
        color: AppColors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      margin: EdgeInsets.zero,
    ),

    // Boutons élevés
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.button.copyWith(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    ),

    // Boutons outlined
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.button.copyWith(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    ),

    // Boutons texte
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.button.copyWith(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      labelStyle: AppTextStyles.label.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.grey400,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      errorStyle: AppTextStyles.error.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    ),

    // Dialogs
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.dialog),
      ),
      titleTextStyle: AppTextStyles.h5.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    ),

    // Bottom sheets
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.bottomSheet),
        ),
      ),
      elevation: 8,
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey800,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.grey200,
      thickness: 1,
      space: 1,
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey100,
      deleteIconColor: AppColors.grey600,
      labelStyle: AppTextStyles.bodySmall.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
    ),
  );
}
