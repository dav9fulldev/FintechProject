import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class TestSikaPage extends StatefulWidget {
  const TestSikaPage({super.key});

  @override
  State<TestSikaPage> createState() => _TestSikaPageState();
}

class _TestSikaPageState extends State<TestSikaPage> {
  static const sikaChannel = MethodChannel('com.gertonargent/sika');

  bool microphonePermissionGranted = false;
  bool sikaServiceRunning = false;
  String? userFirstName;
  String lastCommand = 'Aucune commande';
  List<String> pendingTransactions = [];
  String statusMessage = 'Vérification...';

  @override
  void initState() {
    super.initState();
    checkStatus();
    _setupCommandListener();
  }

  void _setupCommandListener() {
    sikaChannel.setMethodCallHandler((call) async {
      if (call.method == 'onSikaCommand') {
        final String cmd = call.arguments ?? '';
        setState(() {
          lastCommand = cmd;
          statusMessage = '✅ Commande reçue: $cmd';
        });
      }
      return null;
    });
  }

  Future<void> checkStatus() async {
    try {
      // Vérifier permission micro
      final micStatus = await Permission.microphone.status;

      // Vérifier si le service tourne
      final isRunning =
          await sikaChannel.invokeMethod<bool>('isSikaServiceRunning') ?? false;

      // Récupérer le prénom
      final firstName =
          await sikaChannel.invokeMethod<String>('getUserFirstname');

      // Récupérer les transactions en attente
      final transactionsJson =
          await sikaChannel.invokeMethod<String>('readPendingTransactions') ??
              '[]';

      List<dynamic> transactionsList = [];
      if (transactionsJson.isNotEmpty && transactionsJson != '[]') {
        try {
          // Pour l'instant, on garde une liste vide car le format exact n'est pas clair
          transactionsList = [];
        } catch (e) {
          debugPrint('Erreur parsing transactions: $e');
        }
      }

      setState(() {
        microphonePermissionGranted = micStatus.isGranted;
        sikaServiceRunning = isRunning;
        userFirstName = firstName;
        pendingTransactions =
            transactionsList.map((e) => e.toString()).toList();
        statusMessage = isRunning ? '✅ Sika est actif' : '⚠️ Sika est arrêté';
      });
    } catch (e) {
      setState(() {
        statusMessage = '❌ Erreur: $e';
      });
      debugPrint('Erreur vérification status Sika: $e');
    }
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    setState(() => microphonePermissionGranted = status.isGranted);

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Permission microphone accordée'),
          backgroundColor: Color(0xFF1E40AF),
        ),
      );
    }
  }

  Future<void> startSikaService() async {
    try {
      await sikaChannel.invokeMethod('startSikaService');
      await Future.delayed(const Duration(seconds: 1));
      await checkStatus();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎤 Sika démarré ! Dis "Sika" pour tester'),
            backgroundColor: Color(0xFF1E40AF),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
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

  Future<void> stopSikaService() async {
    try {
      await sikaChannel.invokeMethod('stopSikaService');
      await Future.delayed(const Duration(milliseconds: 500));
      await checkStatus();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⏸️ Sika arrêté'),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur arrêt Sika: $e');
    }
  }

  Future<void> setUserFirstName() async {
    final controller = TextEditingController(text: userFirstName ?? '');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Définir ton prénom'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Prénom',
            hintText: 'Ex: David',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await sikaChannel.invokeMethod('setUserFirstname', {
                  'firstname': controller.text.trim(),
                });
                Navigator.pop(context);
                await checkStatus();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('✅ Prénom défini: ${controller.text}'),
                      backgroundColor: const Color(0xFF1E40AF),
                    ),
                  );
                }
              } catch (e) {
                debugPrint('Erreur définition prénom: $e');
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  Future<void> clearPendingTransactions() async {
    try {
      await sikaChannel.invokeMethod('clearPendingTransactions');
      await checkStatus();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🗑️ Transactions en attente effacées'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur effacement transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final allReady = microphonePermissionGranted &&
        sikaServiceRunning &&
        userFirstName != null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        title: const Text(
          'Test Sika Voice Assistant',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: checkStatus,
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
                  colors: allReady
                      ? [const Color(0xFF1E40AF), const Color(0xFF3B82F6)]
                      : [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (allReady ? const Color(0xFF1E40AF) : Colors.orange)
                        .withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    allReady ? Icons.mic : Icons.warning,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    statusMessage,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (userFirstName != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Prénom: $userFirstName',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Configuration Section
            _buildSectionTitle('Configuration'),
            const SizedBox(height: 12),

            _buildConfigCard(
              'Permission Microphone',
              microphonePermissionGranted ? 'Accordée' : 'Non accordée',
              microphonePermissionGranted,
              microphonePermissionGranted ? null : requestMicrophonePermission,
            ),

            const SizedBox(height: 12),

            _buildConfigCard(
              'Service Sika',
              sikaServiceRunning ? 'Actif' : 'Arrêté',
              sikaServiceRunning,
              sikaServiceRunning ? stopSikaService : startSikaService,
              buttonText: sikaServiceRunning ? 'Arrêter' : 'Démarrer',
            ),

            const SizedBox(height: 12),

            _buildConfigCard(
              'Prénom utilisateur',
              userFirstName ?? 'Non défini',
              userFirstName != null,
              setUserFirstName,
              buttonText: 'Modifier',
            ),

            const SizedBox(height: 32),

            // Last Command
            _buildSectionTitle('Dernière commande'),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mic_none, color: Color(0xFF1E40AF)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lastCommand,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Pending Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle(
                    'Transactions en attente (${pendingTransactions.length})'),
                if (pendingTransactions.isNotEmpty)
                  TextButton.icon(
                    onPressed: clearPendingTransactions,
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Effacer'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            if (pendingTransactions.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'Aucune transaction en attente',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...pendingTransactions.map((tx) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      tx,
                      style: const TextStyle(fontSize: 13),
                    ),
                  )),

            const SizedBox(height: 32),

            // Instructions
            _buildSectionTitle('Comment tester ?'),
            const SizedBox(height: 12),

            _buildInstructionCard(
              '1',
              'Accorde la permission microphone',
              Icons.mic,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '2',
              'Définis ton prénom (Sika t\'appellera par ton prénom)',
              Icons.person,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '3',
              'Démarre le service Sika',
              Icons.play_arrow,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '4',
              'Dis "Sika" à voix haute',
              Icons.record_voice_over,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '5',
              'Sika répondra "Oui [ton prénom] ?" et écoutera ta commande',
              Icons.hearing,
            ),
            const SizedBox(height: 8),

            _buildInstructionCard(
              '6',
              'Dis une commande comme: "ajoute 5000 transport" ou "enregistre 10000 alimentation"',
              Icons.shopping_cart,
            ),

            const SizedBox(height: 24),

            // Voice Commands Reference
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF1E40AF).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Color(0xFF1E40AF)),
                      SizedBox(width: 8),
                      Text(
                        'Exemples de commandes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E40AF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildCommandExample('ajoute 5000 transport'),
                  _buildCommandExample('enregistre 10000 alimentation'),
                  _buildCommandExample('note 3000 loisirs'),
                  _buildCommandExample('dépense 15000 logement'),
                ],
              ),
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

  Widget _buildConfigCard(
    String title,
    String value,
    bool isActive,
    VoidCallback? onAction, {
    String? buttonText,
  }) {
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
              color: (isActive ? Colors.green : Colors.orange).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isActive ? Icons.check : Icons.warning,
              color: isActive ? Colors.green : Colors.orange,
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
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (onAction != null)
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E40AF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(buttonText ?? 'Activer'),
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
              color: const Color(0xFF1E40AF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Icon(icon, color: const Color(0xFF1E40AF)),
        ],
      ),
    );
  }

  Widget _buildCommandExample(String command) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFF1E40AF)),
          const SizedBox(width: 8),
          Text(
            '"$command"',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
