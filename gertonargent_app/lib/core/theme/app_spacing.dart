/// Système d'espacement cohérent basé sur une grille de 8dp
class AppSpacing {
  // Espacements de base (multiples de 8)
  static const double xs = 4.0; // Extra small
  static const double sm = 8.0; // Small
  static const double md = 16.0; // Medium
  static const double lg = 24.0; // Large
  static const double xl = 32.0; // Extra large
  static const double xxl = 40.0; // Extra extra large
  static const double xxxl = 48.0; // Triple extra large

  // Espacements spécifiques
  static const double padding = md;
  static const double margin = md;
  static const double cardPadding = 20.0;
  static const double screenPadding = lg;

  // Espacements verticaux
  static const double verticalXs = xs;
  static const double verticalSm = sm;
  static const double verticalMd = md;
  static const double verticalLg = lg;
  static const double verticalXl = xl;

  // Espacements horizontaux
  static const double horizontalXs = xs;
  static const double horizontalSm = sm;
  static const double horizontalMd = md;
  static const double horizontalLg = lg;
  static const double horizontalXl = xl;

  // Espacements entre éléments
  static const double betweenSections = lg;
  static const double betweenCards = md;
  static const double betweenElements = sm;
  static const double betweenTexts = xs;
}
