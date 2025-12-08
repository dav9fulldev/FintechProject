class PlannedPurchase {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final double amount;
  final String category;
  final DateTime? plannedDate;
  final DateTime createdAt;
  final DateTime? purchasedAt;
  final String status; // 'pending', 'purchased', 'cancelled'
  final int? transactionId;

  PlannedPurchase({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.amount,
    required this.category,
    this.plannedDate,
    required this.createdAt,
    this.purchasedAt,
    required this.status,
    this.transactionId,
  });

  factory PlannedPurchase.fromJson(Map<String, dynamic> json) {
    return PlannedPurchase(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      category: json['category'],
      plannedDate: json['planned_date'] != null
          ? DateTime.parse(json['planned_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      purchasedAt: json['purchased_at'] != null
          ? DateTime.parse(json['purchased_at'])
          : null,
      status: json['status'],
      transactionId: json['transaction_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category': category,
      'planned_date': plannedDate?.toIso8601String(),
    };
  }

  bool get isPending => status == 'pending';
  bool get isPurchased => status == 'purchased';
  bool get isCancelled => status == 'cancelled';

  String get categoryEmoji {
    switch (category.toLowerCase()) {
      case 'alimentation':
        return '🍔';
      case 'transport':
        return '🚗';
      case 'logement':
        return '🏠';
      case 'sante':
        return '🏥';
      case 'education':
        return '📚';
      case 'loisirs':
        return '🎮';
      case 'vetements':
        return '👕';
      case 'communication':
        return '📱';
      case 'epargne':
        return '💰';
      default:
        return '📦';
    }
  }

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'En attente';
      case 'purchased':
        return 'Acheté';
      case 'cancelled':
        return 'Annulé';
      default:
        return status;
    }
  }
}
