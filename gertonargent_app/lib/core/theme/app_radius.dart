/// Border radius cohérents pour toute l'application
class AppRadius {
  // Radius de base
  static const double none = 0.0;
  static const double sm = 8.0; // Small - petits boutons, chips
  static const double md = 12.0; // Medium - cards, inputs
  static const double lg = 16.0; // Large - dialogs, bottom sheets
  static const double xl = 20.0; // Extra large - cards importantes
  static const double xxl = 24.0; // Extra extra large
  static const double xxxl = 28.0; // Triple extra large
  static const double full = 9999.0; // Complètement arrondi (pill shape)

  // Radius spécifiques
  static const double button = md;
  static const double card = lg;
  static const double dialog = lg;
  static const double bottomSheet = xl;
  static const double input = md;
  static const double chip = full;
  static const double avatar = full;
}
