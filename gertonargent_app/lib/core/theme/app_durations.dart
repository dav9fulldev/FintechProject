/// Durées d'animations cohérentes
class AppDurations {
  // Durées de base
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Durées spécifiques
  static const Duration splash = Duration(seconds: 2);
  static const Duration pageTransition = normal;
  static const Duration dialogTransition = fast;
  static const Duration buttonPress = Duration(milliseconds: 100);
  static const Duration ripple = normal;
  static const Duration loading = Duration(milliseconds: 400);
  static const Duration snackbar = Duration(seconds: 3);
}
