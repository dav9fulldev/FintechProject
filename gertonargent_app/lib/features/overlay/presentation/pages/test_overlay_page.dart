import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestOverlayPage extends StatefulWidget {
  const TestOverlayPage({super.key});

  @override
  State<TestOverlayPage> createState() => _TestOverlayPageState();
}

class _TestOverlayPageState extends State<TestOverlayPage> {
  static const platform = MethodChannel('com.gertonargent/overlay');

  bool overlayPermissionGranted = false;
  bool accessibilityPermissionGranted = false;
  bool isDetecting = false;

  final TextEditingController _amountController =
      TextEditingController(text: '5000');

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> checkPermissions() async {
    try {
      final result = await platform.invokeMethod('checkPermissions');
      setState(() {
        overlayPermissionGranted = result['overlay'] ?? false;
        accessibilityPermissionGranted = result['accessibility'] ?? false;
      });
    } catch (e) {
      debugPrint('Erreur vérification permissions: $e');
    }
  }

  Future<void> testOverlayWithAmount() async {
    try {
      final amount = double.tryParse(_amountController.text) ?? 5000.0;

      final intent = {
        'ACTION': 'SHOW_TRANSACTION_ALERT',
        'AMOUNT': amount,
      };

      await platform.invokeMethod('startOverlayService', intent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Overlay affiché avec montant: ${amount.toStringAsFixed(0)} FCFA'),
            backgroundColor: const Color(0xFF00A86B),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur affichage overlay: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> testGenericAlert() async {
    try {
      final intent = {
        'ACTION': 'SHOW_ALERT',
      };

      await platform.invokeMethod('startOverlayService', intent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alerte générique affichée'),
            backgroundColor: Color(0xFF00A86B),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur: $e');
    }
  }

  Future<void> hideOverlay() async {
    try {
      final intent = {
        'ACTION': 'HIDE_ALERT',
      };

      await platform.invokeMethod('startOverlayService', intent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Overlay masqué'),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur: $e');
    }
  }

  Future<void> requestOverlayPermission() async {
    try {
      await platform.invokeMethod('requestOverlayPermission');
      await Future.delayed(const Duration(seconds: 1));
      await checkPermissions();
    } catch (e) {
      debugPrint('Erreur: $e');
    }
  }

  Future<void> requestAccessibilityPermission() async {
    try {
      await platform.invokeMethod('requestAccessibilityPermission');
      await Future.delayed(const Duration(seconds: 1));
      await checkPermissions();
    } catch (e) {
      debugPrint('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final allPermissionsGranted =
        overlayPermissionGranted && accessibilityPermissionGranted;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A86B),
        elevation: 0,
        title: const Text(
          'Test Overlay Mobile Money',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: checkPermissions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: allPermissionsGranted
                      ? [const Color(0xFF00A86B), const Color(0xFF00D084)]
                      : [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (allPermissionsGranted
                            ? const Color(0xFF00A86B)
                            : Colors.orange)
                        .withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    allPermissionsGranted ? Icons.check_circle : Icons.warning,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    allPermissionsGranted
                        ? 'Système prêt !'
                        : 'Permissions requises',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    allPermissionsGranted
                        ? 'Toutes les permissions sont activées'
                        : 'Active les permissions ci-dessous',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Permissions Section
            _buildSectionTitle('Permissions'),
            const SizedBox(height: 12),

            _buildPermissionCard(
              'Affichage overlay',
              'Requis pour afficher les alertes',
              overlayPermissionGranted,
              requestOverlayPermission,
            ),

            const SizedBox(height: 12),

            _buildPermissionCard(
              'Accessibilité',
              'Détecte les apps Mobile Money',
              accessibilityPermissionGranted,
              requestAccessibilityPermission,
            ),

            const SizedBox(height: 32),

            // Test Section
            _buildSectionTitle('Tests de l\'overlay'),
            const SizedBox(height: 12),

            // Info box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ces boutons simulent ce qui se passe quand tu utilises Wave, Orange Money, etc.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Amount input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Montant de test (FCFA)',
                prefixIcon:
                    const Icon(Icons.attach_money, color: Color(0xFF00A86B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF00A86B), width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Test buttons
            ElevatedButton.icon(
              onPressed: allPermissionsGranted ? testOverlayWithAmount : null,
              icon: const Icon(Icons.warning_amber),
              label: const Text('Tester alerte avec montant'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A86B),
                disabledBackgroundColor: Colors.grey[300],
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: allPermissionsGranted ? testGenericAlert : null,
              icon: const Icon(Icons.notifications),
              label: const Text('Tester alerte générique'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                disabledBackgroundColor: Colors.grey[300],
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: hideOverlay,
              icon: const Icon(Icons.close),
              label: const Text('Masquer overlay'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Instructions
            _buildSectionTitle('Comment tester en vrai ?'),
            const SizedBox(height: 12),

            _buildInstructionCard(
              '1',
              'Active toutes les permissions ci-dessus',
              Icons.check_circle,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '2',
              'Ouvre Wave, Orange Money ou une autre app Mobile Money',
              Icons.phone_android,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '3',
              'Commence une transaction (transfère de l\'argent)',
              Icons.send,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '4',
              'L\'overlay apparaîtra automatiquement avant la confirmation !',
              Icons.notification_important,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPermissionCard(
    String title,
    String subtitle,
    bool isGranted,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  (isGranted ? Colors.green : Colors.orange).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isGranted ? Icons.check : Icons.warning,
              color: isGranted ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (!isGranted)
            TextButton(
              onPressed: onTap,
              child: const Text('Activer'),
            ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(String number, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF00A86B).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A86B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Icon(icon, color: const Color(0xFF00A86B)),
        ],
      ),
    );
  }
}
