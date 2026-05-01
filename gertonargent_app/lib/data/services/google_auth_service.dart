import 'package:google_sign_in/google_sign_in.dart';

/// Service pour gérer l'authentification Google
class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await _googleSignIn.initialize(
        serverClientId: '1044256435944-spfhvk7hrq6e79a9m0uadcprobf2umhg.apps.googleusercontent.com',
      );
      _initialized = true;
    }
  }

  /// Se connecter avec Google
  Future<GoogleSignInAccount?> signIn() async {
    try {
      await _ensureInitialized();
      final account = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );
      return account;
    } catch (error) {
      if (error is GoogleSignInException && error.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw Exception('Erreur lors de la connexion Google: $error');
    }
  }

  /// Obtenir le token ID Google
  Future<String?> getIdToken(GoogleSignInAccount account) async {
    try {
      // Dans google_sign_in >= 7.0.0, l'authentification est synchrone
      final auth = account.authentication;
      return auth.idToken;
    } catch (error) {
      throw Exception('Erreur lors de l\'obtention du token: $error');
    }
  }

  /// Se déconnecter
  Future<void> signOut() async {
    await _ensureInitialized();
    await _googleSignIn.signOut();
  }

  /// Vérifier si l'utilisateur est déjà connecté
  Future<GoogleSignInAccount?> getCurrentUser() async {
    await _ensureInitialized();
    return await _googleSignIn.attemptLightweightAuthentication();
  }

  /// Déconnexion silencieuse (sans dialogue)
  Future<void> disconnect() async {
    await _ensureInitialized();
    await _googleSignIn.disconnect();
  }
}
