# 🎙️ SIKA — Assistant Vocal Intelligent

Bienvenue dans la documentation officielle de **Sika**, l'assistant financier vocal de GèrTonArgent. Sika est conçu pour vous aider à gérer vos finances par la voix, avec une approche 100% hors-ligne pour garantir votre confidentialité.

---

## 🗺️ Index de la Documentation

Pour une prise en main rapide ou une compréhension approfondie, suivez ces guides :

1.  **[Démarrage Rapide (V2)](SIKA_QUICK_START.md)** : Installez et testez Sika en 15 minutes.
2.  **[Commandes Vocales](SIKA_VOICE_COMMANDS.md)** : Liste des exemples de ce que vous pouvez dire à Sika.
3.  **[Guide d'Implémentation](SIKA_IMPLEMENTATION_GUIDE.md)** : Détails techniques sur l'architecture (Kotlin/Dart).
4.  **[Scénarios de Test](SIKA_TEST_SCENARIOS.md)** : Comment vérifier que tout fonctionne correctement.

---

## 🧠 Pourquoi Sika ?

Sika n'est pas juste un gadget. C'est une innovation fintech majeure :
-   **Prévention Active** : Contrairement aux autres apps, Sika intervient *avant* la dépense.
-   **100% Confidentialité** : Le traitement vocal (Vosk/Android) se fait sur votre téléphone. Aucune donnée audio ne quitte l'appareil.
-   **Friction Cognitive** : Sika vous aide à réfléchir à l'impact de chaque dépense sur vos objectifs d'épargne.

---

## 🛠️ État Technique (V2)

L'implémentation actuelle utilise la version **V2** des services natifs :
-   **Cerveau** : `SikaWakeWordServiceV2.kt` (Détection de volume et logique STT).
-   **Interface** : `SikaOverlayServiceV2.kt` (Bulle flottante interactive).
-   **Pont** : `MainActivity.kt` gère la communication bidirectionnelle avec Flutter.

---
*GèrTonArgent — Reprenez le contrôle de votre argent par la voix.*
