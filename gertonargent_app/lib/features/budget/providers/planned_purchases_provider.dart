import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/planned_purchase.dart';
import '../../../data/services/api_service.dart';

final plannedPurchasesProvider =
    StateNotifierProvider<PlannedPurchasesNotifier, PlannedPurchasesState>(
  (ref) => PlannedPurchasesNotifier(ref.read(apiServiceProvider)),
);

class PlannedPurchasesState {
  final List<PlannedPurchase> purchases;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? summary;

  PlannedPurchasesState({
    this.purchases = const [],
    this.isLoading = false,
    this.error,
    this.summary,
  });

  PlannedPurchasesState copyWith({
    List<PlannedPurchase>? purchases,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? summary,
  }) {
    return PlannedPurchasesState(
      purchases: purchases ?? this.purchases,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      summary: summary ?? this.summary,
    );
  }

  List<PlannedPurchase> get pendingPurchases =>
      purchases.where((p) => p.isPending).toList();

  List<PlannedPurchase> get completedPurchases =>
      purchases.where((p) => p.isPurchased).toList();

  double get totalPendingAmount =>
      pendingPurchases.fold(0.0, (sum, p) => sum + p.amount);

  double get totalCompletedAmount =>
      completedPurchases.fold(0.0, (sum, p) => sum + p.amount);
}

class PlannedPurchasesNotifier extends StateNotifier<PlannedPurchasesState> {
  final ApiService _apiService;

  PlannedPurchasesNotifier(this._apiService) : super(PlannedPurchasesState());

  Future<void> loadPurchases({String? statusFilter}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await _apiService.getPlannedPurchases(status: statusFilter);
      final purchases =
          data.map((json) => PlannedPurchase.fromJson(json)).toList();

      state = state.copyWith(
        purchases: purchases,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadSummary() async {
    try {
      final summary = await _apiService.getPlannedPurchasesSummary();
      state = state.copyWith(summary: summary);
    } catch (e) {
      // Ignore summary errors
    }
  }

  Future<bool> createPurchase({
    required String name,
    required double amount,
    required String category,
    String? description,
    DateTime? plannedDate,
  }) async {
    try {
      await _apiService.createPlannedPurchase(
        name: name,
        amount: amount,
        category: category,
        description: description,
        plannedDate: plannedDate,
      );

      // Recharger la liste
      await loadPurchases();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> updatePurchase({
    required int id,
    String? name,
    double? amount,
    String? category,
    String? description,
    DateTime? plannedDate,
    String? status,
  }) async {
    try {
      await _apiService.updatePlannedPurchase(
        id: id,
        name: name,
        amount: amount,
        category: category,
        description: description,
        plannedDate: plannedDate,
        status: status,
      );

      await loadPurchases();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> deletePurchase(int id) async {
    try {
      await _apiService.deletePlannedPurchase(id);
      await loadPurchases();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> markAsCompleted(int id, {int? transactionId}) async {
    try {
      await _apiService.markPurchaseAsCompleted(
        id: id,
        transactionId: transactionId,
      );
      await loadPurchases();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
