import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/planned_purchase.dart';
import '../../providers/planned_purchases_provider.dart';
import '../widgets/add_purchase_dialog.dart';

class ShoppingListPage extends ConsumerStatefulWidget {
  const ShoppingListPage({super.key});

  @override
  ConsumerState<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends ConsumerState<ShoppingListPage> {
  String _filterStatus = 'all';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(plannedPurchasesProvider.notifier).loadPurchases();
      ref.read(plannedPurchasesProvider.notifier).loadSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(plannedPurchasesProvider);
    final filteredPurchases = _filterStatus == 'all'
        ? state.purchases
        : _filterStatus == 'pending'
            ? state.pendingPurchases
            : state.completedPurchases;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Ma Liste d\'Achats'),
        backgroundColor: const Color(0xFF00A86B),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(plannedPurchasesProvider.notifier).loadPurchases();
              ref.read(plannedPurchasesProvider.notifier).loadSummary();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Résumé
          _buildSummaryCard(state),

          // Filtres
          _buildFilterChips(),

          // Liste des achats
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredPurchases.isEmpty
                    ? _buildEmptyState()
                    : _buildPurchasesList(filteredPurchases),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(PlannedPurchasesState state) {
    final summary = state.summary;
    final totalPlanned = summary?['total_planned_amount'] ?? 0.0;
    final totalPurchased = summary?['total_purchased_amount'] ?? 0.0;
    final pendingCount = summary?['pending_count'] ?? 0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00A86B), Color(0xFF00D084)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A86B).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _summaryItem(
                  '📋',
                  '$pendingCount',
                  'À acheter',
                ),
              ),
              Expanded(
                child: _summaryItem(
                  '💰',
                  '${NumberFormat('#,###', 'fr_FR').format(totalPlanned)} F',
                  'Montant prévu',
                ),
              ),
              Expanded(
                child: _summaryItem(
                  '✅',
                  '${NumberFormat('#,###', 'fr_FR').format(totalPurchased)} F',
                  'Déjà acheté',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _filterChip('all', 'Tous'),
          const SizedBox(width: 8),
          _filterChip('pending', 'En attente'),
          const SizedBox(width: 8),
          _filterChip('purchased', 'Achetés'),
        ],
      ),
    );
  }

  Widget _filterChip(String value, String label) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterStatus = value);
      },
      selectedColor: const Color(0xFF00A86B).withValues(alpha: 0.2),
      checkmarkColor: const Color(0xFF00A86B),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 24),
          const Text(
            'Aucun achat planifié',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ajoute ce que tu veux acheter',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddPurchaseDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Ajouter un achat'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A86B),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchasesList(List<PlannedPurchase> purchases) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return _buildPurchaseCard(purchase);
      },
    );
  }

  Widget _buildPurchaseCard(PlannedPurchase purchase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showPurchaseOptions(purchase),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Emoji catégorie
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: purchase.isPurchased
                      ? Colors.grey.withValues(alpha: 0.1)
                      : const Color(0xFF00A86B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  purchase.categoryEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),

              // Infos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: purchase.isPurchased
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      purchase.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (purchase.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        purchase.description!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Montant et statut
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${NumberFormat('#,###', 'fr_FR').format(purchase.amount)} F',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: purchase.isPurchased
                          ? Colors.grey
                          : const Color(0xFF00A86B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: purchase.isPurchased
                          ? Colors.grey.withValues(alpha: 0.2)
                          : const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      purchase.statusLabel,
                      style: TextStyle(
                        fontSize: 10,
                        color: purchase.isPurchased
                            ? Colors.grey[700]
                            : const Color(0xFFFF9800),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddPurchaseDialog(),
    );
  }

  void _showPurchaseOptions(PlannedPurchase purchase) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                purchase.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (purchase.isPending) ...[
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Marquer comme acheté'),
                  onTap: () {
                    Navigator.pop(context);
                    _markAsCompleted(purchase.id);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blue),
                  title: const Text('Modifier'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Show edit dialog
                  },
                ),
              ],
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Supprimer'),
                onTap: () {
                  Navigator.pop(context);
                  _deletePurchase(purchase);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _markAsCompleted(int id) async {
    final success =
        await ref.read(plannedPurchasesProvider.notifier).markAsCompleted(id);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? '✅ Achat marqué comme effectué' : '❌ Erreur',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _deletePurchase(PlannedPurchase purchase) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer cet achat ?'),
        content: Text('Supprimer "${purchase.name}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(plannedPurchasesProvider.notifier)
          .deletePurchase(purchase.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Achat supprimé' : 'Erreur'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }
}
