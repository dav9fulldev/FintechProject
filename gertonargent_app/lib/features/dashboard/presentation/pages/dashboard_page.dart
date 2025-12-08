import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/widgets/modern_cards.dart';
import '../../../../core/utils/page_transitions.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../budget/providers/budget_provider.dart';
import '../../../transactions/providers/transaction_provider.dart';
import '../../../goals/providers/goal_provider.dart';
import '../../../budget/presentation/pages/budget_list_page.dart';
import '../../../transactions/presentation/pages/add_transaction_page.dart';
import '../../../transactions/presentation/pages/transaction_history_page.dart';
import '../../../goals/presentation/pages/goals_list_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    ref.read(budgetProvider.notifier).loadBudgets();
    ref.read(transactionProvider.notifier).loadTransactions();
    ref.read(goalProvider.notifier).loadGoals();
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return '${formatter.format(amount)} FCFA';
  }

  String _getCurrentMonth() {
    final months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return months[DateTime.now().month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final budgetState = ref.watch(budgetProvider);
    final transactionState = ref.watch(transactionProvider);
    final authState = ref.watch(authProvider);

    final totalBudget = budgetState.totalBudget;
    final totalSpent = budgetState.totalSpent;
    final progress = totalBudget > 0 ? (totalSpent / totalBudget) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'GèrTonArgent',
              style: AppTextStyles.h6.copyWith(color: AppColors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.white),
            onPressed: _loadData,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec gradient
              GradientCard(
                gradient: AppColors.primaryGradient,
                padding: EdgeInsets.all(AppSpacing.lg),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.xl),
                  bottomRight: Radius.circular(AppRadius.xl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenue${authState.user != null ? ", ${authState.user!.username}" : ""} !',
                      style: AppTextStyles.h4.copyWith(color: AppColors.white),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'Gérez vos finances intelligemment',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    // Carte Budget
                    ModernCard(
                      padding: EdgeInsets.all(AppSpacing.md),
                      boxShadow: AppShadows.card,
                      child: budgetState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Budget du mois',
                                      style: AppTextStyles.h6,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: AppSpacing.xs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.full),
                                      ),
                                      child: Text(
                                        _getCurrentMonth(),
                                        style: AppTextStyles.label.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSpacing.md),
                                Text(
                                  _formatCurrency(totalSpent),
                                  style: AppTextStyles.amount.copyWith(
                                    color: progress > 0.9
                                        ? AppColors.error
                                        : progress > 0.7
                                            ? AppColors.warning
                                            : AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Dépensés sur ${_formatCurrency(totalBudget)}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.md),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.sm),
                                  child: LinearProgressIndicator(
                                    value: progress.clamp(0, 1),
                                    minHeight: 8,
                                    backgroundColor: AppColors.grey200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      progress > 0.9
                                          ? AppColors.error
                                          : progress > 0.7
                                              ? AppColors.warning
                                              : AppColors.primary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Reste: ${_formatCurrency(budgetState.totalRemaining)}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              // Actions rapides
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actions rapides',
                      style: AppTextStyles.h5,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.account_balance_wallet,
                            title: 'Mes budgets',
                            subtitle:
                                '${budgetState.budgets.length} catégories',
                            color: AppColors.primary,
                            onTap: () {
                              context.pushSlideFade(const BudgetListPage());
                            },
                          ),
                        ),
                        SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.flag,
                            title: 'Mes objectifs',
                            subtitle:
                                '${ref.watch(goalProvider).activeGoals.length} en cours',
                            color: AppColors.warning,
                            onTap: () {
                              context.pushSlideFade(const GoalsListPage());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.add_circle_outline,
                            title: 'Nouvelle dépense',
                            subtitle: 'Ajouter',
                            color: AppColors.info,
                            onTap: () async {
                              await context
                                  .pushSlideFade(const AddTransactionPage());
                              _loadData();
                            },
                          ),
                        ),
                        SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.history,
                            title: 'Historique',
                            subtitle:
                                '${transactionState.transactions.length} transactions',
                            color: AppColors.accent,
                            onTap: () {
                              context.pushSlideFade(
                                  const TransactionHistoryPage());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              // Transactions récentes
              if (transactionState.recentTransactions.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions récentes',
                        style: AppTextStyles.h5,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushSlideFade(const TransactionHistoryPage());
                        },
                        child: Text('Voir tout',
                            style: AppTextStyles.button
                                .copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                ...transactionState.recentTransactions
                    .take(5)
                    .map((transaction) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                    child: ModernCard(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              transaction.categoryIcon,
                              style: AppTextStyles.h6,
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.description ??
                                      transaction.categoryName,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  transaction.formattedDate,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            transaction.formattedAmount,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: transaction.type.name == 'expense'
                                  ? AppColors.error
                                  : AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
              SizedBox(height: AppSpacing.xxxl * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      onTap: onTap,
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
