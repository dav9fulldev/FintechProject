import 'package:flutter/material.dart';

/// Palette de couleurs de l'application GèrTonArgent
/// Utilise withValues() pour une meilleure précision des couleurs
class AppColors {
  // Couleurs principales — Bleu premium
  static const Color primary = Color(0xFF1E40AF);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFF3B82F6);

  // Couleurs secondaires
  static const Color secondary = Color(0xFF2196F3);
  static const Color secondaryLight = Color(0xFF64B5F6);
  static const Color secondaryDark = Color(0xFF1976D2);

  // Couleurs d'accentuation
  static const Color accent = Color(0xFF9C27B0);
  static const Color accentLight = Color(0xFFBA68C8);

  // Couleurs de statut
  static const Color success = Color(0xFF059669);
  static const Color successLight = Color(0xFF34D399);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color info = Color(0xFF2196F3);

  // Couleurs neutres
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Couleurs avec transparence (utilise withValues pour précision)
  static Color get primaryWithOpacity10 => primary.withValues(alpha: 0.1);
  static Color get primaryWithOpacity20 => primary.withValues(alpha: 0.2);
  static Color get primaryWithOpacity30 => primary.withValues(alpha: 0.3);
  static Color get primaryWithOpacity50 => primary.withValues(alpha: 0.5);

  static Color get blackWithOpacity5 => black.withValues(alpha: 0.05);
  static Color get blackWithOpacity10 => black.withValues(alpha: 0.1);
  static Color get blackWithOpacity20 => black.withValues(alpha: 0.2);
  static Color get blackWithOpacity50 => black.withValues(alpha: 0.5);

  static Color get whiteWithOpacity70 => white.withValues(alpha: 0.7);
  static Color get whiteWithOpacity90 => white.withValues(alpha: 0.9);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentLight],
  );

  // Couleurs des catégories de budget
  static const Color alimentation = Color(0xFFFF6B6B);
  static const Color transport = Color(0xFF4ECDC4);
  static const Color logement = Color(0xFF95E1D3);
  static const Color sante = Color(0xFFF38181);
  static const Color education = Color(0xFFAA96DA);
  static const Color loisirs = Color(0xFFFCBF49);
  static const Color epargne = Color(0xFF06D6A0);
  static const Color vetements = Color(0xFFEF476F);
  static const Color communication = Color(0xFF118AB2);
  static const Color autre = Color(0xFF8D99AE);

  // Couleurs de fond
  static const Color backgroundLight = Color(0xFFF0F4FF);
  static const Color surfaceLight = white;
  static const Color cardLight = white;

  // Couleurs de texte
  static const Color textPrimary = grey900;
  static const Color textSecondary = grey600;
  static const Color textTertiary = grey400;
  static const Color textOnPrimary = white;
}
