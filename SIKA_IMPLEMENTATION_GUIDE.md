# 🛠️ Guide d'Implémentation Technique — Sika

Ce guide détaille l'architecture et la configuration technique de l'assistant vocal Sika pour les développeurs.

---

## 🏗️ Architecture (V2)

Sika repose sur une communication fluide entre la couche Android native et le framework Flutter.

### 1. Services Natifs (Kotlin)
- **`SikaWakeWordServiceV2`** : Gère l'écoute continue. Utilise une détection de volume pour le réveil et l'API `SpeechRecognizer` d'Android pour capturer les commandes.
- **`SikaOverlayServiceV2`** : Gère l'interface visuelle flottante (bulle noire) qui donne un feedback en temps réel à l'utilisateur.
- **`SikaConfig`** : Contient tous les paramètres ajustables (seuil de volume, délais STT, limites de montants).

### 2. Couche Flutter (Dart)
- **`SikaNative`** : Classe wrapper `MethodChannel` pour dialoguer avec le code Kotlin.
- **`SikaSync`** : Gère la synchronisation des transactions enregistrées vocalement vers le backend FastAPI.
- **`RegistrationCache`** : Système de persistence locale (Hive) pour éviter la perte de données lors de l'onboarding.

---

## 🔐 Configuration des Permissions

### Android (`AndroidManifest.xml`)
Indispensable pour le fonctionnement en arrière-plan et l'accès au micro.

```xml
<!-- Enregistrement audio -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<!-- Service au premier plan -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<!-- Affichage par-dessus les autres apps -->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

<application>
    <service android:name=".SikaWakeWordServiceV2" android:foregroundServiceType="microphone" />
    <service android:name=".SikaOverlayServiceV2" />
</application>
```

---

## 🔄 Flux de Données

1.  **Détection** : Le micro capte "Sika" (via volume sonore).
2.  **Capture** : STT convertit la voix en texte ("ajoute 5000 transport").
3.  **Parsing** : Regex extrait le montant (5000) et la catégorie (transport).
4.  **Stockage** : JSON sauvegardé dans les `SharedPreferences` (natif).
5.  **Synchro** : Flutter récupère le JSON au démarrage/resume et l'envoie au backend.

---

## 🔍 Troubleshooting (Debug)

### Voir les logs en direct
```bash
adb logcat | grep SikaV2
```

### Problèmes fréquents :
- **Bruit ambiant** : Si Sika se réveille tout seul, augmentez `LOUDNESS_THRESHOLD` dans `SikaConfig.kt`.
- **Permissions** : Sur certains téléphones (Xiaomi/Samsung), il faut autoriser manuellement "Afficher sur l'écran de verrouillage" et "Démarrage automatique".
- **Synchro** : Vérifiez que l'utilisateur est bien connecté (`auth_token` présent) avant que `SikaSync` ne se lance.

---
*GèrTonArgent — Architecture robuste pour une souveraineté financière.*
