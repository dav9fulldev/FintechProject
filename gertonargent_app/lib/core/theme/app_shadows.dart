import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Ombres cohérentes et subtiles pour l'application
class AppShadows {
  // Ombres légères (élévation 1-2)
  static List<BoxShadow> get light => [
        BoxShadow(
          color: AppColors.blackWithOpacity5,
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];

  // Ombres moyennes (élévation 3-4)
  static List<BoxShadow> get medium => [
        BoxShadow(
          color: AppColors.blackWithOpacity10,
          blurRadius: 8,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ];

  // Ombres fortes (élévation 5-8)
  static List<BoxShadow> get strong => [
        BoxShadow(
          color: AppColors.blackWithOpacity20,
          blurRadius: 12,
          offset: const Offset(0, 6),
          spreadRadius: 0,
        ),
      ];

  // Ombre pour cards
  static List<BoxShadow> get card => [
        BoxShadow(
          color: AppColors.blackWithOpacity5,
          blurRadius: 10,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];

  // Ombre pour boutons élevés
  static List<BoxShadow> get button => [
        BoxShadow(
          color: AppColors.primaryWithOpacity30,
          blurRadius: 8,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ];

  // Ombre pour dialogs et bottom sheets
  static List<BoxShadow> get dialog => [
        BoxShadow(
          color: AppColors.blackWithOpacity20,
          blurRadius: 20,
          offset: const Offset(0, 10),
          spreadRadius: 0,
        ),
      ];

  // Ombre inner (effet enfoncé)
  static List<BoxShadow> get inner => [
        BoxShadow(
          color: AppColors.blackWithOpacity10,
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: -2,
        ),
      ];

  // Pas d'ombre
  static List<BoxShadow> get none => [];
}
