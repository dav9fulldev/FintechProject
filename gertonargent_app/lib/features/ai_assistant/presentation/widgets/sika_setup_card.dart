import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// Card pour activer Sika avec vérification des permissions
class SikaSetupCard extends StatefulWidget {
  const SikaSetupCard({super.key});

  @override
  State<SikaSetupCard> createState() => _SikaSetupCardState();
}

class _SikaSetupCardState extends State<SikaSetupCard> {
  static const sikaChannel = MethodChannel('com.gertonargent/sika');
  static const overlayChannel = MethodChannel('com.gertonargent/overlay');

  bool _isLoading = true;
  bool _micPermission = false;
  bool _overlayPermission = false;
  bool _sikaRunning = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    setState(() => _isLoading = true);

    try {
      // Vérifier permission micro
      final micStatus = await Permission.microphone.status;
      _micPermission = micStatus.isGranted;

      // Vérifier permission overlay
      final perms = await overlayChannel.invokeMethod('checkPermissions');
      _overlayPermission = perms['overlay'] == true;

      // Vérifier si Sika tourne
      final running =
          await sikaChannel.invokeMethod<bool>('isSikaServiceRunning') ?? false;
      _sikaRunning = running;

      setState(() => _isLoading = false);
    } catch (e) {
      debugPrint('[SikaSetupCard] Erreur: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Permission microphone accordée'),
            backgroundColor: Color(0xFF00A86B),
          ),
        );
      }
      await _checkStatus();
    } else if (status.isPermanentlyDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Veuillez activer le microphone dans les paramètres'),
            action: SnackBarAction(
              label: 'Ouvrir',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _requestOverlayPermission() async {
    try {
      await overlayChannel.invokeMethod('requestOverlayPermission');
      await Future.delayed(const Duration(seconds: 2));
      await _checkStatus();
    } catch (e) {
      debugPrint('[SikaSetupCard] Erreur overlay: $e');
    }
  }

  Future<void> _startSika() async {
    if (!_micPermission || !_overlayPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Toutes les permissions sont nécessaires'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      await sikaChannel.invokeMethod('startSikaService');
      await Future.delayed(const Duration(seconds: 1));
      await _checkStatus();

      if (mounted && _sikaRunning) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎤 Sika activé ! Dites "Sika" pour parler'),
            backgroundColor: Color(0xFF00A86B),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      debugPrint('[SikaSetupCard] Erreur démarrage: $e');
    }
  }

  Future<void> _stopSika() async {
    try {
      await sikaChannel.invokeMethod('stopSikaService');
      await Future.delayed(const Duration(milliseconds: 500));
      await _checkStatus();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⏸️ Sika désactivé'),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      debugPrint('[SikaSetupCard] Erreur arrêt: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final allPermissionsGranted = _micPermission && _overlayPermission;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec icône
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00A86B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Color(0xFF00A86B),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assistant Vocal Sika',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _sikaRunning ? '🟢 Actif - Dites "Sika"' : '⚪ Inactif',
                        style: TextStyle(
                          fontSize: 14,
                          color: _sikaRunning
                              ? const Color(0xFF00A86B)
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Bouton principal
                if (allPermissionsGranted)
                  ElevatedButton.icon(
                    onPressed: _sikaRunning ? _stopSika : _startSika,
                    icon: Icon(_sikaRunning ? Icons.stop : Icons.play_arrow),
                    label: Text(_sikaRunning ? 'Arrêter' : 'Démarrer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _sikaRunning
                          ? Colors.grey[700]
                          : const Color(0xFF00A86B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Permissions requises
            const Text(
              'Permissions requises:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Permission Microphone
            _buildPermissionTile(
              icon: Icons.mic,
              title: 'Microphone',
              subtitle: 'Pour écouter votre voix',
              granted: _micPermission,
              onTap: _micPermission ? null : _requestMicPermission,
            ),

            const SizedBox(height: 8),

            // Permission Overlay
            _buildPermissionTile(
              icon: Icons.layers,
              title: 'Affichage superposé',
              subtitle: 'Pour afficher Sika au-dessus des apps',
              granted: _overlayPermission,
              onTap: _overlayPermission ? null : _requestOverlayPermission,
            ),

            // Message d'aide
            if (!allPermissionsGranted) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: Colors.orange[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Activez toutes les permissions pour utiliser Sika',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Message de succès
            if (allPermissionsGranted && _sikaRunning) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A86B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00A86B), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Color(0xFF00A86B), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sika est prêt !',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00A86B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Même quand l\'app est fermée, dites "Sika" pour enregistrer une dépense',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool granted,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: granted ? Colors.green[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: granted ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: granted ? Colors.green : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: granted ? Colors.green[800] : Colors.grey[700],
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: granted ? Colors.green[600] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              granted ? Icons.check_circle : Icons.arrow_forward_ios,
              color: granted ? Colors.green : Colors.grey[400],
              size: granted ? 24 : 16,
            ),
          ],
        ),
      ),
    );
  }
}
