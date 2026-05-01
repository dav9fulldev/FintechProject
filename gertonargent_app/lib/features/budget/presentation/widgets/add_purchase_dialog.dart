import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/planned_purchases_provider.dart';

class AddPurchaseDialog extends ConsumerStatefulWidget {
  const AddPurchaseDialog({super.key});

  @override
  ConsumerState<AddPurchaseDialog> createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends ConsumerState<AddPurchaseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'alimentation';
  DateTime? _plannedDate;

  final List<Map<String, dynamic>> _categories = [
    {'value': 'alimentation', 'label': 'Alimentation', 'emoji': '🍔'},
    {'value': 'transport', 'label': 'Transport', 'emoji': '🚗'},
    {'value': 'logement', 'label': 'Logement', 'emoji': '🏠'},
    {'value': 'vetements', 'label': 'Vêtements', 'emoji': '👕'},
    {'value': 'loisirs', 'label': 'Loisirs', 'emoji': '🎮'},
    {'value': 'sante', 'label': 'Santé', 'emoji': '🏥'},
    {'value': 'education', 'label': 'Éducation', 'emoji': '📚'},
    {'value': 'communication', 'label': 'Communication', 'emoji': '📱'},
    {'value': 'autre', 'label': 'Autre', 'emoji': '📦'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Titre
                  const Text(
                    'Ajouter un achat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Nom de l'achat
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom de l\'achat',
                      hintText: 'Ex: Chaussures',
                      prefixIcon: const Icon(Icons.shopping_bag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requis';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Montant
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Montant',
                      hintText: '50000',
                      prefixIcon: const Icon(Icons.attach_money),
                      suffixText: 'FCFA',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requis';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Montant invalide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Catégorie
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Catégorie',
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: _categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat['value'] as String,
                        child: Row(
                          children: [
                            Text(cat['emoji'] as String,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                cat['label'] as String,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedCategory = value!);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Description (optionnel)
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description (optionnel)',
                      hintText: 'Détails',
                      prefixIcon: const Icon(Icons.notes),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),

                  // Date prévue (optionnel)
                  InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date prévue',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _plannedDate == null
                            ? 'Optionnel'
                            : '${_plannedDate!.day}/${_plannedDate!.month}/${_plannedDate!.year}',
                        style: TextStyle(
                          color:
                              _plannedDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annuler'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E40AF),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Ajouter'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _plannedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final amount = double.parse(_amountController.text.trim());
    final description = _descriptionController.text.trim();

    // Afficher loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final success =
        await ref.read(plannedPurchasesProvider.notifier).createPurchase(
              name: name,
              amount: amount,
              category: _selectedCategory,
              description: description.isEmpty ? null : description,
              plannedDate: _plannedDate,
            );

    if (mounted) {
      // Fermer le loading
      Navigator.pop(context);

      if (success) {
        // Fermer le dialogue
        Navigator.pop(context);

        // Afficher confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Achat ajouté à ta liste'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Erreur lors de l\'ajout'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
