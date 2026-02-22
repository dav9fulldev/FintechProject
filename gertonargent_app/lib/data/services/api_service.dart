import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';

// Provider Riverpod pour ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

/// Service central de communication avec l'API FastAPI.
/// Utilise le client Dio avec des intercepteurs pour la gestion des tokens.
/// Design Pattern : Singleton (Instance unique pour toute l'app).
class ApiService {
  late Dio _dio;
  String? _token;
  int _userId = 1;

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Injection automatique du token JWT dans les headers
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        debugPrint('ERROR MESSAGE: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  void setToken(String token) {
    _token = token;
  }

  /// Indique si un token est présent (utilisé pour des vérifications simples)
  bool get hasToken => _token != null;

  void setUserId(int userId) {
    _userId = userId;
  }

  int get userId => _userId;

  // ==================== AUTH ====================

  Future<Map<String, dynamic>> register({
    required String email,
    required String username,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final data = <String, dynamic>{
        'email': email,
        'username': username,
        'password': password,
      };
      if (firstName != null) data['first_name'] = firstName;
      if (lastName != null) data['last_name'] = lastName;

      final response = await _dio.post(
        ApiConstants.register,
        data: data,
      );
      if (response.data['access_token'] != null) {
        setToken(response.data['access_token']);
      }
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Register using a full payload map (useful for multi-step forms)
  Future<Map<String, dynamic>> registerWithPayload(
      Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: payload,
      );
      if (response.data['access_token'] != null) {
        setToken(response.data['access_token']);
      }
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.data['access_token'] != null) {
        setToken(response.data['access_token']);
      }
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      if (response.data['id'] != null) {
        setUserId(response.data['id']);
      }
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? phone,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (firstName != null) data['first_name'] = firstName;
      if (phone != null) data['phone'] = phone;

      final response = await _dio.put(
        ApiConstants.me,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        '/auth/change-password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== BUDGETS ====================

  Future<List<dynamic>> getBudgets() async {
    try {
      final response = await _dio.get(
        ApiConstants.budgets,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getBudgetsSummary() async {
    try {
      final response = await _dio.get(
        ApiConstants.budgetsSummary,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createBudget({
    required String category,
    required double monthlyLimit,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.budgets,
        data: {
          'category': category,
          'monthly_limit': monthlyLimit,
        },
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateBudget({
    required int budgetId,
    double? monthlyLimit,
    double? currentSpent,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (monthlyLimit != null) data['monthly_limit'] = monthlyLimit;
      if (currentSpent != null) data['current_spent'] = currentSpent;

      final response = await _dio.put(
        '${ApiConstants.budgets}$budgetId',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteBudget(int budgetId) async {
    try {
      await _dio.delete('${ApiConstants.budgets}$budgetId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== TRANSACTIONS ====================

  Future<List<dynamic>> getTransactions({
    String? category,
    String? transactionType,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'user_id': _userId,
        'limit': limit,
        'offset': offset,
      };
      if (category != null) queryParams['category'] = category;
      if (transactionType != null)
        queryParams['transaction_type'] = transactionType;

      final response = await _dio.get(
        ApiConstants.transactions,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getTransactionsSummary() async {
    try {
      final response = await _dio.get(
        ApiConstants.transactionsSummary,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createTransaction({
    required double amount,
    required String category,
    String? description,
    String transactionType = 'expense',
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.transactions,
        data: {
          'amount': amount,
          'category': category,
          'description': description,
          'transaction_type': transactionType,
        },
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _dio.delete('${ApiConstants.transactions}$transactionId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== GOALS ====================

  Future<List<dynamic>> getGoals({bool includeCompleted = true}) async {
    try {
      final response = await _dio.get(
        ApiConstants.goals,
        queryParameters: {
          'user_id': _userId,
          'include_completed': includeCompleted,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getGoalsSummary() async {
    try {
      final response = await _dio.get(
        ApiConstants.goalsSummary,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createGoal({
    required String name,
    String? description,
    required double targetAmount,
    DateTime? targetDate,
    String icon = 'flag',
    String color = '#00A86B',
  }) async {
    try {
      final data = <String, dynamic>{
        'name': name,
        'target_amount': targetAmount,
        'icon': icon,
        'color': color,
      };
      if (description != null) data['description'] = description;
      if (targetDate != null)
        data['target_date'] = targetDate.toIso8601String();

      final response = await _dio.post(
        ApiConstants.goals,
        data: data,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateGoal({
    required int goalId,
    String? name,
    String? description,
    double? targetAmount,
    double? currentAmount,
    DateTime? targetDate,
    String? icon,
    String? color,
    bool? isCompleted,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (targetAmount != null) data['target_amount'] = targetAmount;
      if (currentAmount != null) data['current_amount'] = currentAmount;
      if (targetDate != null)
        data['target_date'] = targetDate.toIso8601String();
      if (icon != null) data['icon'] = icon;
      if (color != null) data['color'] = color;
      if (isCompleted != null) data['is_completed'] = isCompleted;

      final response = await _dio.put(
        '${ApiConstants.goals}$goalId',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> addToGoal({
    required int goalId,
    required double amount,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.goals}$goalId/add',
        data: {'amount': amount},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteGoal(int goalId) async {
    try {
      await _dio.delete('${ApiConstants.goals}$goalId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== AI ====================

  Future<Map<String, dynamic>> analyzeTransaction({
    required double amount,
    required String category,
    String? description,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.aiAnalyze,
        data: {
          'amount': amount,
          'category': category,
          'description': description,
        },
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getRecommendations() async {
    try {
      final response = await _dio.post(
        ApiConstants.aiRecommend,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getPredictions() async {
    try {
      final response = await _dio.post(
        ApiConstants.aiPredict,
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> sendVoiceQuery(String query) async {
    try {
      final response = await _dio.post(
        ApiConstants.aiVoice,
        data: {'query': query},
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== SIKA ASSISTANT ====================

  Future<Map<String, dynamic>> sikaChat(String query) async {
    try {
      final response = await _dio.post(
        ApiConstants.sikaChat,
        data: {'query': query},
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> sikaConfirmTransaction({
    required double amount,
    required String category,
    String? description,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.sikaConfirm,
        data: {
          'amount': amount,
          'category': category,
          'description': description ?? 'Dépense via Sika',
        },
        queryParameters: {'user_id': _userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== PLANNED PURCHASES (Liste d'achats) ====================

  Future<List<Map<String, dynamic>>> getPlannedPurchases(
      {String? status}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status_filter'] = status;

      final response = await _dio.get(
        '/planned-purchases/',
        queryParameters: queryParams,
      );
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createPlannedPurchase({
    required String name,
    required double amount,
    required String category,
    String? description,
    DateTime? plannedDate,
  }) async {
    try {
      final response = await _dio.post(
        '/planned-purchases/',
        data: {
          'name': name,
          'amount': amount,
          'category': category,
          'description': description,
          'planned_date': plannedDate?.toIso8601String(),
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updatePlannedPurchase({
    required int id,
    String? name,
    double? amount,
    String? category,
    String? description,
    DateTime? plannedDate,
    String? status,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (amount != null) data['amount'] = amount;
      if (category != null) data['category'] = category;
      if (description != null) data['description'] = description;
      if (plannedDate != null)
        data['planned_date'] = plannedDate.toIso8601String();
      if (status != null) data['status'] = status;

      final response = await _dio.put(
        '/planned-purchases/$id',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deletePlannedPurchase(int id) async {
    try {
      await _dio.delete('/planned-purchases/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> markPurchaseAsCompleted({
    required int id,
    int? transactionId,
  }) async {
    try {
      final response = await _dio.post(
        '/planned-purchases/$id/mark-purchased',
        queryParameters:
            transactionId != null ? {'transaction_id': transactionId} : null,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getPlannedPurchasesSummary() async {
    try {
      final response = await _dio.get('/planned-purchases/stats/summary');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== ERROR HANDLING ====================

  String _handleError(DioException e) {
    /// Traduit les erreurs techniques réseau en messages compréhensibles pour l'utilisateur.
    /// Gère les timeouts, les erreurs HTTP (400, 401, 500) et les pertes de connexion.
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connexion au serveur expirée. Vérifiez votre connexion internet.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (statusCode == 400) {
          return data?['detail'] ?? 'Requête invalide';
        } else if (statusCode == 401) {
          return data?['detail'] ?? 'Non autorisé. Veuillez vous reconnecter.';
        } else if (statusCode == 404) {
          return data?['detail'] ?? 'Ressource non trouvée';
        } else if (statusCode == 500) {
          return 'Erreur serveur. Réessayez plus tard.';
        }
        return data?['detail'] ?? 'Erreur inconnue';
      case DioExceptionType.connectionError:
        return 'Impossible de se connecter au serveur. Vérifiez que le backend est lancé.';
      default:
        return 'Une erreur est survenue: ${e.message}';
    }
  }
}
