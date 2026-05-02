import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/google_auth_service.dart';
import '../../../data/models/user_model.dart';

final googleAuthServiceProvider = Provider((ref) => GoogleAuthService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final api = ref.read(apiServiceProvider);
  final google = ref.read(googleAuthServiceProvider);
  return AuthNotifier(api, google);
});

class AuthState {
  final bool isAuthenticated;
  final UserModel? user;
  final String? token;
  final bool isLoading;
  final String? error;

  AuthState({
    this.isAuthenticated = false,
    this.user,
    this.token,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserModel? user,
    String? token,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final GoogleAuthService _googleAuthService;

  AuthNotifier(this._apiService, this._googleAuthService) : super(AuthState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      final token = response['access_token'];
      final userJson = response['user'];
      UserModel? user;
      if (userJson != null) {
        try {
          user = UserModel.fromJson(userJson);
        } catch (_) {}
      }

      _apiService.setToken(token);
      if (user != null) {
        _apiService.setUserId(user.id);
      }

      // Charger la photo de profil locale
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final localPic = prefs.getString('profile_pic_${user.id}');
        if (localPic != null) {
          user = user.copyWith(profilePicture: localPic);
        }
      }

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        user: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      print('❌ Login error: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString().contains('401')
            ? 'Email ou mot de passe incorrect'
            : 'Erreur de connexion. Veuillez réessayer.',
      );
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.register(
        email: email,
        username: username,
        phone: phone,
        password: password,
      );

      final token = response['access_token'];
      final userJson = response['user'];
      UserModel? user;
      if (userJson != null) {
        try {
          user = UserModel.fromJson(userJson);
        } catch (_) {}
      }

      _apiService.setToken(token);
      if (user != null) {
        _apiService.setUserId(user.id);
      }

      // Charger la photo de profil locale
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final localPic = prefs.getString('profile_pic_${user.id}');
        if (localPic != null) {
          user = user.copyWith(profilePicture: localPic);
        }
      }

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        user: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur d\'inscription. Veuillez réessayer.',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // final googleAuthService = GoogleAuthService();
      
      // Étape 1: Connexion Google
      print('🔐 Tentative de connexion Google...');
      final account = await _googleAuthService.signIn();
      
      if (account == null) {
        print('❌ Aucun compte sélectionné');
        state = state.copyWith(
          isLoading: false,
          error: 'Connexion Google annulée',
        );
        return;
      }
      
      print('✅ Compte Google connecté: ${account.email}');
      
      // Étape 2: Obtenir le token ID
      print('🔑 Récupération du token ID...');
      final idToken = await _googleAuthService.getIdToken(account);
      
      if (idToken == null || idToken.isEmpty) {
        print('❌ Token ID vide ou null');
        state = state.copyWith(
          isLoading: false,
          error: 'Impossible d\'obtenir le token Google. Vérifiez la configuration du Client ID dans Google Cloud Console.',
        );
        return;
      }
      
      print('✅ Token ID obtenu (${idToken.length} caractères)');
      
      // Étape 3: Envoyer au backend
      print('📤 Envoi du token au backend...');
      final response = await _apiService.googleAuth(idToken: idToken);
      
      final token = response['access_token'];
      final userJson = response['user'];
      UserModel? user;
      if (userJson != null) {
        try {
          user = UserModel.fromJson(userJson);
        } catch (_) {}
      }

      _apiService.setToken(token);
      if (user != null) {
        _apiService.setUserId(user.id);
      }
      
      print('✅ Authentification réussie!');

      // Charger la photo de profil locale
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final localPic = prefs.getString('profile_pic_${user.id}');
        if (localPic != null) {
          user = user.copyWith(profilePicture: localPic);
        }
      }

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        user: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      print('❌ Erreur Google Sign-In: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur de connexion avec Google. Veuillez réessayer.',
      );
    }
  }

  void initializeFromToken({String? token, UserModel? user}) {
    if (token == null || token.isEmpty) return;
    _apiService.setToken(token);
    
    // Charger la photo de profil locale asynchronement si possible
    // Note: initializeFromToken est synchrone, donc on peut faire un refreshUser après ou gérer ici
    state = state.copyWith(
      isAuthenticated: true,
      token: token,
      user: user ?? state.user,
      error: null,
    );
    
    // Charger la photo de profil locale
    if (state.user != null) {
      SharedPreferences.getInstance().then((prefs) {
        final localPic = prefs.getString('profile_pic_${state.user!.id}');
        if (localPic != null) {
          state = state.copyWith(
            user: state.user!.copyWith(profilePicture: localPic),
          );
        }
      });
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  Future<void> refreshUser() async {
    try {
      final userResponse = await _apiService.getMe();
      var user = UserModel.fromJson(userResponse);

      // Charger la photo de profil locale
      final prefs = await SharedPreferences.getInstance();
      final localPic = prefs.getString('profile_pic_${user.id}');
      if (localPic != null) {
        user = user.copyWith(profilePicture: localPic);
      }

      state = state.copyWith(user: user);
    } catch (e) {
      // Ignorer les erreurs de rafraîchissement
    }
  }

  Future<void> updateProfilePicture(String path) async {
    if (state.user != null) {
      state = state.copyWith(
        user: state.user!.copyWith(profilePicture: path),
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_pic_${state.user!.id}', path);
    }
  }

  void logout() {
    state = AuthState();
    _apiService.setToken('');
  }
}
