# 🚀 SIKA V2 — Guide de Démarrage Rapide (5 Minutes)

Ce guide vous permet de configurer l'assistant vocal Sika sur votre environnement de développement Android.

## 📦 Ce que vous installez
Un système d'assistant vocal complet incluant :
- 🎤 **Écoute passive** : Détecte "Sika" même si l'application est fermée (Service V2).
- 🗣️ **Interactivité** : Vous salue par votre prénom via la synthèse vocale (TTS).
- 👂 **Commandes de dépenses** : Capture les montants et catégories à la voix (STT).
- 🔄 **Synchronisation** : Sauvegarde locale immédiate et envoi automatique au backend dès que l'app s'ouvre.

---

## ⚡ Installation Rapide

### Étape 1 : Services Natifs Kotlin
Copiez les fichiers de service V2 dans votre dossier Android :
`android/app/src/main/kotlin/com/example/gertonargent_app/`
- `SikaWakeWordServiceV2.kt` (Cœur du service)
- `SikaOverlayServiceV2.kt` (Interface flottante)
- `SikaConfig.kt` (Paramètres de sensibilité)

### Étape 2 : Pont Flutter (MainActivity.kt)
Dans votre `MainActivity.kt`, assurez-vous d'utiliser `SikaWakeWordServiceV2` pour les appels système. Le code doit gérer le `MethodChannel` "com.gertonargent/sika".

### Étape 3 : Configuration Android (AndroidManifest.xml)
Ajoutez les permissions et services nécessaires :
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

<service android:name=".SikaWakeWordServiceV2" android:foregroundServiceType="microphone" />
<service android:name=".SikaOverlayServiceV2" />
```

---

## 🧪 Tester en 30 Secondes

1. **Déploiement** : Lancez l'application sur votre appareil (`flutter run`).
2. **Permissions** : Acceptez l'accès au micro et l'autorisation de dessiner par-dessus les autres apps.
3. **Activation** : Fermez l'application (elle doit rester en arrière-plan).
4. **Appel** : Dites clairement "**Sika**".
5. **Commande** : "Ajoute 5000 transport".
6. **Confirmation** : Sika vous répondra vocalement pour confirmer l'enregistrement.

---

## 🎤 Exemples de Commandes
- "Ajoute dépense 5000 transport"
- "Enregistre 10000 en repas"
- "Ajouter 2500 taxi"

---

## 🔍 Debugging
- Utilisez `adb logcat | grep SikaV2` pour voir les logs système.
- Vérifiez que le volume de l'appareil est activé pour entendre les réponses de Sika.

Pour plus de détails techniques, consultez le **[Guide d'Implémentation](SIKA_IMPLEMENTATION_GUIDE.md)**.
