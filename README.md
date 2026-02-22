# 🎯 GèrTonArgent v2.0

**L'application qui PRÉVIENT vos dépenses avant qu'elles n'arrivent.**

---

## 🔥 La Révolution Fintech en Afrique

GèrTonArgent n'est pas une simple application de budget. C'est un **garde du corps financier** intelligent qui utilise l'IA pour intervenir au moment le plus critique : *juste avant la transaction*.

### 🚀 Points Forts
- 🎤 **Assistant Vocal Sika** : Une commande vocale 100% hors-ligne pour enregistrer vos dépenses sans effort.
- 🛡️ **Protection Mobile Money** : Détection automatique des flux Wave, Orange, MTN et Moov pour une analyse de budget en temps réel.
- 🧠 **Analyse Prédictive** : Des conseils personnalisés basés sur votre historique pour éviter le découvert.
- 🔐 **Confidentialité Totale** : Vos données financières et vocales restent sur votre appareil.

---

## 📚 Documentation Sika

Pour plus de détails sur l'assistant vocal, consultez les guides suivants :
- **[Point d'entrée Sika](README_SIKA.md)**
- **[Guide de démarrage rapide](SIKA_QUICK_START.md)**
- **[Commandes vocales](SIKA_VOICE_COMMANDS.md)**
- **[Scénarios de test](SIKA_TEST_SCENARIOS.md)**

---

## 🏗️ Structure du Projet

```
gertonargent_v2/
├── backend/                # API FastAPI (Python)
├── gertonargent_app/       # Application Flutter (Dart)
│   ├── android/            # Services natifs Kotlin
│   └── lib/                # Logique métier et UI Flutter
└── docs/                   # Documentation technique
```

---

## 🛠️ État d'Avancement (Février 2026)

- [x] **Backend** : Entièrement documenté et stable.
- [x] **Frontend** : UI Premium et State Management (Riverpod) fonctionnels.
- [x] **Natif Android** : Détection Sika V2 et Mobile Money opérationnels.
- [x] **Documentation** : Entièrement refondue en français pour une approche pédagogique.

---
*GèrTonArgent — Reprenez le contrôle.*
---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🚀 LA RÉVOLUTION DE LA GESTION FINANCIÈRE EN AFRIQUE

**GèrTonArgent n'est pas une simple app de budget - c'est votre garde du corps financier !**

### 💡 Le Problème

Les apps de gestion financière traditionnelles vous aident à voir **après coup** où va votre argent. Mais c'est **trop tard** ! La dépense est déjà faite.

### ✨ Notre Solution Révolutionnaire

**GèrTonArgent intervient AVANT que vous ne dépensiez !**

L'application fonctionne en **arrière-plan intelligent** et détecte automatiquement quand vous :
- 📱 Ouvrez Wave, Orange Money, Moov Money ou MTN
- 📸 Scannez un code QR pour payer
- 💸 Initiez un transfert ou un paiement

➜ **À CE MOMENT PRÉCIS**, une fenêtre intelligente apparaît :

```
⚠️ ALERTE BUDGET !

Transaction : 50,000 FCFA
Impact : 28% de ton budget mensuel restant

🎯 Rappel : Tu économises pour ton "Terrain à Yopougon"
   Progression : 2,000,000 / 5,000,000 FCFA (40%)

💭 Conseil IA :
   - Tu as déjà dépensé 180,000 FCFA ce mois-ci
   - Il reste 3 semaines avant fin du mois
   - Cette dépense ralentit ton objectif de 2 mois

Continuer quand même ?

[✓ Oui, continuer]  [✗ Non, annuler]
```

**Vous gardez le contrôle total !** L'app ne bloque jamais vos transactions - elle vous informe simplement pour que vous décidiez en toute conscience.

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🌟 Pourquoi GèrTonArgent Change Tout

| Critère | Apps Classiques | **GèrTonArgent** |
|---------|-----------------|------------------|
| **Moment d'action** | Après la dépense ❌ | **AVANT la transaction** ✅ |
| **Type d'aide** | Statistiques passives | **Prévention active** ✅ |
| **Intégration bancaire** | Nécessaire (complexe) | **Aucune API requise** ✅ |
| **Mode de fonctionnement** | App à ouvrir | **Surveillance automatique** ✅ |
| **Confidentialité** | Données partagées | **100% local** ✅ |
| **Compatibilité** | Apps spécifiques | **Toutes apps Mobile Money** ✅ |
| **Permissions** | Accès comptes bancaires | **Observation seulement** ✅ |

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## ✨ Fonctionnalités Complètes

### 🔥 CŒUR DE L'INNOVATION - Service Overlay (Phase 2 - En cours)

#### 1. **Overlay Intelligent**
- 🔍 Détection automatique des apps Mobile Money (Wave, Orange, Moov, MTN)
- 🪟 Fenêtre flottante contextuelle
- ⚡ Intervention en temps réel (< 0.5 secondes)
- 🎯 Alertes personnalisées basées sur vos données

#### 2. **Assistant IA Vocal** 🎤
Parlez à votre assistant financier comme à Siri :

*"Hey GèrTonArgent, est-ce que je peux acheter ce jean à 25,000 FCFA ?"*

**Réponse instantanée :**
```
🤖 "Salut ! Ton budget vêtements ce mois-ci est déjà utilisé 
à 80% (40,000 / 50,000 FCFA). Si tu achètes ce jean, il te 
restera seulement 5,000 FCFA pour 12 jours. 

💡 Mon conseil : Attends la semaine prochaine, ou utilise 
ton budget loisirs qui a encore 15,000 FCFA disponibles.

Tu veux continuer ?"
```

#### 3. **Analyse Prédictive IA** 🧠
- 📊 Prévisions de fin de mois
- 🚨 Détection des dépenses inhabituelles
- 💡 Recommandations personnalisées
- 📈 Tendances et patterns de dépenses
- ⚠️ Alertes proactives avant les problèmes

### ✅ Fonctionnalités de Base (Phase 1 - TERMINÉE)

#### 💰 Gestion des Budgets
- Création de budgets par catégorie (Alimentation, Transport, Logement, etc.)
- Suivi en temps réel de l'utilisation
- Alertes automatiques (50%, 80%, 100%)
- Ajustements mensuels intelligents

#### 📊 Suivi des Transactions
- Ajout manuel de transactions
- Catégorisation automatique
- Historique complet avec recherche
- Statistiques détaillées
- Export de données (CSV, PDF)

#### 🎯 Objectifs d'Épargne
- Création d'objectifs multiples
- Suivi de progression visuel
- Rappels intelligents
- Calcul automatique des économies nécessaires
- Prévisions d'atteinte d'objectifs

#### 📱 Interface Moderne
- Design inspiré des couleurs ivoiriennes 🇨🇮
- Navigation intuitive avec Bottom Bar
- Dark Mode (bientôt)
- Animations fluides
- Performance optimale

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🛠️ Stack Technique Complet

### 🎨 Frontend Mobile
```
Flutter 3.0+                 - Framework UI cross-platform
├── Riverpod                 - State management moderne
├── Dio                      - Client HTTP avec intercepteurs
├── Hive                     - Base de données locale NoSQL
├── SharedPreferences        - Stockage sécurisé
├── FL Chart                 - Graphiques et statistiques
├── Intl                     - Internationalisation
└── Google Fonts             - Typographies personnalisées
```

### 🔧 Backend API
```
FastAPI                      - Framework Python ultra-rapide
├── PostgreSQL 15            - Base de données relationnelle
├── SQLAlchemy               - ORM puissant
├── Alembic                  - Migrations de DB
├── Pydantic                 - Validation de données
├── JWT                      - Authentification sécurisée
├── OpenAI API               - Intelligence artificielle
├── Uvicorn                  - Serveur ASGI
└── Python-dotenv            - Gestion variables d'environnement
```

### 📲 Services Android Natifs
```
Accessibility Service        - Détection apps Mobile Money
├── System Alert Window      - Overlay flottant
├── Foreground Service       - Surveillance continue
├── Notification Manager     - Alertes système
├── Speech Recognition       - STT (Speech-to-Text)
├── Text-to-Speech           - TTS pour assistant vocal
├── Method Channel           - Communication Flutter ↔ Native
└── WorkManager              - Tâches en arrière-plan
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📦 Installation Complète

### 📋 Prérequis

**Système :**
- Windows 10/11, macOS 10.15+, ou Linux
- 8 GB RAM minimum (16 GB recommandé)
- 10 GB d'espace disque libre

**Logiciels :**
- [Flutter SDK 3.0+](https://flutter.dev/docs/get-started/install)
- [Python 3.11+](https://www.python.org/downloads/)
- [PostgreSQL 15+](https://www.postgresql.org/download/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (optionnel mais recommandé)
- [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/downloads)

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

### 1️⃣ Cloner le Projet

```bash
# Via HTTPS
git clone https://github.com/votre-username/gertonargent-v2.git

# Ou via SSH
git clone git@github.com:votre-username/gertonargent-v2.git

cd gertonargent-v2
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

### 2️⃣ Configuration Backend

#### Option A : Avec Docker (Recommandé) 🐳

```bash
cd backend

# Créer et activer l'environnement virtuel
python -m venv venv

# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Lancer PostgreSQL avec Docker
docker run --name gertonargent-db \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=gertonargent_db \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -d postgres:15

# Attendre que la DB démarre (5-10 secondes)
sleep 10

# Créer le fichier .env
echo "DATABASE_URL=postgresql://postgres:postgres@localhost:5432/gertonargent_db" > .env
echo "SECRET_KEY=$(openssl rand -hex 32)" >> .env
echo "OPENAI_API_KEY=your_openai_key_here" >> .env

# Lancer le serveur
python main.py
```

#### Option B : Installation Locale de PostgreSQL

```bash
cd backend

# Créer l'environnement virtuel
python -m venv venv
venv\Scripts\activate  # Windows
source venv/bin/activate  # Linux/Mac

# Installer PostgreSQL localement
# Windows: https://www.postgresql.org/download/windows/
# Mac: brew install postgresql@15
# Linux: sudo apt-get install postgresql-15

# Créer la base de données
createdb gertonargent_db

# Configurer .env
cp .env.example .env
# Éditer .env avec vos paramètres

# Installer les dépendances
pip install -r requirements.txt

# Lancer le serveur
python main.py
```

Le backend sera accessible sur : **http://localhost:8000**
Documentation API : **http://localhost:8000/docs**

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

### 3️⃣ Configuration Frontend

```bash
cd gertonargent_app

# Installer les dépendances Flutter
flutter pub get

# Configurer l'IP du backend
# Éditer : lib/core/constants/api_constants.dart

# Trouver votre IP locale
# Windows:
ipconfig

# Linux/Mac:
ifconfig

# Remplacer dans api_constants.dart :
# baseUrl = 'http://VOTRE_IP:8000'
# Exemple: baseUrl = 'http://192.168.1.10:8000'

# Vérifier les appareils connectés
flutter devices

# Lancer sur Android
flutter run -d DEVICE_ID

# Ou pour un build de production
flutter build apk --release
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

### 4️⃣ Configuration des Permissions Android

Modifier `android/app/src/main/AndroidManifest.xml` :

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <uses-permission android:name="android.permission.BIND_ACCESSIBILITY_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    
    <!-- ... reste du manifest ... -->
</manifest>
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🏗️ Architecture Détaillée

```
gertonargent_v2/
│
├── 📱 gertonargent_app/           # Application Flutter
│   ├── android/                   # Configuration Android
│   │   ├── app/
│   │   │   ├── src/main/
│   │   │   │   ├── kotlin/        # Services natifs Android
│   │   │   │   │   └── com/gertonargent/
│   │   │   │   │       ├── OverlayService.kt
│   │   │   │   │       ├── AccessibilityService.kt
│   │   │   │   │       └── MainActivity.kt
│   │   │   │   ├── AndroidManifest.xml
│   │   │   │   └── res/           # Ressources
│   │   │   └── build.gradle
│   │   └── build.gradle
│   │
│   ├── lib/                       # Code Dart/Flutter
│   │   ├── core/                  # Fonctionnalités globales
│   │   │   ├── constants/
│   │   │   │   ├── api_constants.dart
│   │   │   │   └── app_colors.dart
│   │   │   ├── theme/
│   │   │   │   └── app_theme.dart
│   │   │   └── utils/
│   │   │
│   │   ├── data/                  # Couche de données
│   │   │   ├── models/            # Modèles de données
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── budget_model.dart
│   │   │   │   ├── transaction_model.dart
│   │   │   │   └── goal_model.dart
│   │   │   ├── repositories/      # Gestion des sources de données
│   │   │   └── services/          # Services (API, DB locale)
│   │   │       └── api_service.dart
│   │   │
│   │   └── features/              # Fonctionnalités par module
│   │       ├── auth/              # Authentification
│   │       │   ├── providers/
│   │       │   │   └── auth_provider.dart
│   │       │   └── presentation/
│   │       │       └── pages/
│   │       │           ├── splash_page.dart
│   │       │           ├── login_page.dart
│   │       │           └── register_page.dart
│   │       │
│   │       ├── budget/            # Gestion des budgets
│   │       │   ├── providers/
│   │       │   │   └── budget_provider.dart
│   │       │   └── presentation/
│   │       │       └── pages/
│   │       │           ├── budget_list_page.dart
│   │       │           └── create_budget_page.dart
│   │       │
│   │       ├── transactions/      # Transactions
│   │       │   ├── providers/
│   │       │   │   └── transaction_provider.dart
│   │       │   └── presentation/
│   │       │       └── pages/
│   │       │           ├── add_transaction_page.dart
│   │       │           └── transaction_history_page.dart
│   │       │
│   │       ├── goals/             # Objectifs d'épargne
│   │       │   ├── providers/
│   │       │   │   └── goal_provider.dart
│   │       │   └── presentation/
│   │       │       └── pages/
│   │       │           ├── goals_list_page.dart
│   │       │           └── add_goal_page.dart
│   │       │
│   │       ├── dashboard/         # Tableau de bord
│   │       │   └── presentation/
│   │       │       └── pages/
│   │       │           └── dashboard_page.dart
│   │       │
│   │       ├── navigation/        # Navigation principale
│   │       │   └── main_navigation.dart
│   │       │
│   │       └── overlay/           # Service Overlay (Phase 2)
│   │           ├── overlay_service.dart
│   │           └── overlay_widget.dart
│   │
│   ├── assets/                    # Ressources statiques
│   │   ├── images/
│   │   │   └── logo.png
│   │   └── animations/
│   │
│   ├── pubspec.yaml               # Dépendances Flutter
│   └── main.dart                  # Point d'entrée
│
├── 🔧 backend/                    # API FastAPI
│   ├── app/
│   │   ├── models/                # Modèles SQLAlchemy
│   │   │   ├── user.py
│   │   │   ├── budget.py
│   │   │   ├── transaction.py
│   │   │   └── goal.py
│   │   │
│   │   ├── routes/                # Endpoints API
│   │   │   ├── auth.py
│   │   │   ├── budgets.py
│   │   │   ├── transactions.py
│   │   │   ├── goals.py
│   │   │   └── ai.py
│   │   │
│   │   ├── services/              # Logique métier
│   │   │   ├── ai_service.py
│   │   │   └── notification_service.py
│   │   │
│   │   ├── utils/                 # Utilitaires
│   │   │   ├── security.py
│   │   │   └── database.py
│   │   │
│   │   └── config.py              # Configuration
│   │
│   ├── alembic/                   # Migrations DB
│   │   └── versions/
│   │
│   ├── tests/                     # Tests unitaires
│   │
│   ├── .env.example               # Template variables d'environnement
│   ├── requirements.txt           # Dépendances Python
│   ├── alembic.ini                # Config migrations
│   └── main.py                    # Point d'entrée
│
├── 📄 docs/                       # Documentation
│   ├── API.md
│   ├── OVERLAY.md
│   └── DEPLOYMENT.md
│
├── 🧪 tests/                      # Tests E2E
│
├── .gitignore
├── .env.example
├── LICENSE
└── README.md
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🎨 Design System

### Palette de Couleurs (Inspirée de la Côte d'Ivoire 🇨🇮)

```dart
// Couleurs principales
Primary Green:    #00A86B  // Espoir, croissance
Secondary Orange: #FF6B00  // Énergie, attention
Background:       #FFFFFF  // Clarté
Surface:          #F5F5F5  // Élégance

// Couleurs fonctionnelles
Success:          #4CAF50  // Budget OK
Warning:          #FF9800  // Budget 80%
Danger:           #F44336  // Budget dépassé
Info:             #2196F3  // Informations
```

### Typographie

```
Headings:  Inter Bold, 24-32px
Body:      Inter Regular, 14-16px
Caption:   Inter Regular, 12px
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📱 Screenshots

### Écran Principal
![Dashboard](docs/screenshots/dashboard.png)

### Gestion des Transactions
![Transactions](docs/screenshots/transactions.png)

### Objectifs d'Épargne
![Objectifs](docs/screenshots/objectifs.png)

### Overlay en Action
![Overlay Alert](docs/screenshots/overlay.png)

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🚀 Roadmap Détaillée

### ✅ Phase 1 - Fondations (TERMINÉE - Nov 2025)
- [x] Backend API complet avec FastAPI
- [x] Base de données PostgreSQL
- [x] Authentification JWT sécurisée
- [x] Interface Flutter moderne
- [x] Gestion des budgets par catégorie
- [x] Suivi des transactions
- [x] Objectifs d'épargne
- [x] Navigation avec Bottom Bar
- [x] Splash screen professionnel

### 🔥 Phase 2 - INNOVATION (En cours - Nov 2025)
- [ ] **Service Accessibility Android**
  - [ ] Détection apps Mobile Money
  - [ ] Capture d'événements utilisateur
  - [ ] Extraction de montants
- [ ] **Overlay Window Intelligent**
  - [ ] Fenêtre flottante système
  - [ ] UI contextuelle dynamique
  - [ ] Boutons d'action (Continuer/Annuler)
- [ ] **Assistant IA Vocal**
  - [ ] Intégration Speech-to-Text
  - [ ] Intégration Text-to-Speech
  - [ ] Commandes vocales naturelles
- [ ] **Logique IA Avancée**
  - [ ] Analyse pré-transaction
  - [ ] Prédictions de fin de mois
  - [ ] Recommandations personnalisées
  - [ ] Détection d'anomalies

### 📊 Phase 3 - Statistiques (Déc 2025)
- [ ] Dashboard statistiques avancé
- [ ] Graphiques interactifs (FL Chart)
- [ ] Analyse par catégorie
- [ ] Tendances temporelles
- [ ] Export de rapports (PDF, Excel)
- [ ] Comparaisons mois par mois

### 🌐 Phase 4 - Perfectionnement (Janv 2026)
- [ ] Mode hors ligne complet
- [ ] Synchronisation cloud
- [ ] Multi-devises (CFA, EUR, USD)
- [ ] Dark mode
- [ ] Widgets Android
- [ ] Notifications push intelligentes
- [ ] Catégories personnalisables

### 🎯 Phase 5 - Gamification (Janv 2026)
- [ ] Système de badges
- [ ] Défis d'épargne
- [ ] Classements entre amis
- [ ] Récompenses virtuelles
- [ ] Streaks de bonne gestion

### 🔗 Phase 6 - Intégrations (Fév 2026)
- [ ] API Mobile Money (si disponible)
- [ ] Import bancaire automatique
- [ ] Synchronisation Google Drive
- [ ] Export vers comptabilité

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🧪 Tests

### Lancer les tests Backend
```bash
cd backend
pytest
pytest --cov=app tests/
```

### Lancer les tests Flutter
```bash
cd gertonargent_app
flutter test
flutter test --coverage
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📚 Documentation API

Documentation interactive disponible sur :
- **Swagger UI** : http://localhost:8000/docs
- **ReDoc** : http://localhost:8000/redoc

### Principaux Endpoints

#### Authentification
```
POST /auth/register      - Inscription
POST /auth/login         - Connexion
GET  /auth/me            - Profil utilisateur
```

#### Budgets
```
GET    /budgets/         - Liste des budgets
POST   /budgets/         - Créer un budget
GET    /budgets/{id}     - Détails d'un budget
PUT    /budgets/{id}     - Modifier un budget
DELETE /budgets/{id}     - Supprimer un budget
```

#### Transactions
```
GET    /transactions/    - Liste des transactions
POST   /transactions/    - Ajouter une transaction
DELETE /transactions/{id}- Supprimer une transaction
```

#### Objectifs
```
GET    /goals/           - Liste des objectifs
POST   /goals/           - Créer un objectif
PUT    /goals/{id}       - Mettre à jour un objectif
DELETE /goals/{id}       - Supprimer un objectif
```

#### Intelligence Artificielle
```
POST /ai/analyze         - Analyser une transaction
POST /ai/recommend       - Obtenir des recommandations
POST /ai/predict         - Prédictions de fin de mois
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🔒 Sécurité & Confidentialité

### Engagement de Protection des Données

✅ **Aucune donnée bancaire stockée** - Nous n'avons jamais accès à vos identifiants
✅ **Traitement 100% local** - Les analyses se font sur votre appareil
✅ **Chiffrement AES-256** - Toutes les données sensibles sont chiffrées
✅ **Tokens JWT** - Authentification sécurisée avec expiration
✅ **HTTPS uniquement** - Communications cryptées
✅ **Conformité RGPD** - Respect des normes européennes
✅ **Conformité BCEAO** - Respect des réglementations africaines
✅ **Code open source** - Transparence totale
✅ **Pas de revente de données** - Votre vie privée n'est pas à vendre

### Permissions Android Justifiées

| Permission | Justification |
|------------|--------------|
| `SYSTEM_ALERT_WINDOW` | Pour afficher l'overlay au-dessus des apps |
| `BIND_ACCESSIBILITY_SERVICE` | Pour détecter les apps Mobile Money |
| `INTERNET` | Pour synchroniser avec le backend |
| `RECORD_AUDIO` | Pour l'assistant vocal (optionnel) |
| `POST_NOTIFICATIONS` | Pour les alertes intelligentes |

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🤝 Contribution

Nous accueillons toutes les contributions ! 🎉

### Comment Contribuer

1. **Fork** le projet
2. **Créer** une branche pour votre fonctionnalité
   ```bash
   git checkout -b feature/MaSuperFonctionnalite
   ```
3. **Commiter** vos changements
   ```bash
   git commit -m "✨ Ajout de ma super fonctionnalité"
   ```
4. **Pousser** vers la branche
   ```bash
   git push origin feature/MaSuperFonctionnalite
   ```
5. **Ouvrir** une Pull Request

### Guidelines

- Code en **anglais** (commentaires en français acceptés)
- Tests unitaires obligatoires pour les nouvelles fonctionnalités
- Respect des conventions Flutter/Dart et PEP8 (Python)
- Documentation claire dans le code
- Commits atomiques et descriptifs

### Domaines de Contribution

- 🐛 Correction de bugs
- ✨ Nouvelles fonctionnalités
- 📚 Amélioration de la documentation
- 🎨 Design et UX
- 🌍 Traductions (Anglais, Allemand, etc.)
- 🧪 Tests et qualité

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📄 Licence

Ce projet est sous licence **MIT**. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

```
MIT License

Copyright (c) 2024 GèrTonArgent Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 👨‍💻 Équipe

### Développeur Principal
**YAO BROU DAVID** - Développeur Fullstack
- 🐙 GitHub: dav9fulldev (https://github.com/dav9fulldev)
- 💼 LinkedIn: Brou David YAO (https://www.linkedin.com/in/brou-david-yao)
- 📧 Email: broudavid505@gmail.com
- 🌐 Portfolio: [votre-site.com](https://votre-site.com)

### Contributeurs
Merci à tous ceux qui ont contribué ! 🙏

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🙏 Remerciements

- 💙 **Communauté Flutter** - Pour le framework incroyable
- ⚡ **Équipe FastAPI** - Pour l'API framework le plus rapide
- 🤖 **OpenAI** - Pour l'intelligence artificielle
- 🌍 **Utilisateurs africains** - Pour l'inspiration et les retours
- 🎨 **Designers** - Pour les maquettes et le design system
- 🧪 **Testeurs beta** - Pour leur patience et leurs retours

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📞 Support & Contact

### Besoin d'Aide ?

- 📧 **Email Support** : support@gertonargent.com
- 💬 **Discord Communauté** : [Rejoindre](https://discord.gg/gertonargent)
- 🐛 **Signaler un Bug** : [GitHub Issues](https://github.com/votre-username/gertonargent-v2/issues)
- 💡 **Proposer une Fonctionnalité** : [Discussions](https://github.com/votre-username/gertonargent-v2/discussions)
- 📱 **WhatsApp** : +225 0799053977
- 🐦 **Twitter** : [@gertonargent](https://twitter.com/gertonargent)

### FAQ

**Q: L'app fonctionnera-t-elle hors ligne ?**
R: Oui ! Phase 4 inclut le mode hors ligne complet.

**Q: Mes données bancaires sont-elles en sécurité ?**
R: Nous ne stockons AUCUNE donnée bancaire. L'app observe uniquement vos actions.

**Q: L'app bloque-t-elle mes transactions ?**
R: Non ! Vous gardez toujours le contrôle total.

**Q: Quels opérateurs Mobile Money sont supportés ?**
R: Wave, Orange Money, Moov Money, MTN Money (CI).

**Q: L'app est-elle gratuite ?**
R: Oui, 100% gratuite et open source !

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🌍 Vision & Mission

### Notre Vision
**Démocratiser la gestion financière intelligente en Afrique**

### Notre Mission
Permettre à chaque africain de prendre le contrôle de ses finances grâce à une technologie simple, accessible et respectueuse de la vie privée.

### Nos Valeurs
- 🎯 **Innovation** - Nous repoussons les limites
- 🔒 **Confidentialité** - Vos données vous appartiennent
- 🌍 **Accessibilité** - Pour tous, partout
- 💚 **Simplicité** - Facile à utiliser pour tous
- 🤝 **Communauté** - Construit avec et pour les utilisateurs

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🎓 Ressources & Apprentissage

### Documentation Technique
- [Guide du Service Overlay](docs/OVERLAY.md)
- [Architecture Backend](docs/BACKEND.md)
- [Guide de Déploiement](docs/DEPLOYMENT.md)
- [API Reference](docs/API.md)

### Tutoriels
- [Créer un Service Accessibility](docs/tutorials/accessibility.md)
- [Implémenter un Overlay](docs/tutorials/overlay.md)
- [Intégration IA](docs/tutorials/ai-integration.md)

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 📊 Statistiques du Projet

![GitHub Stars](https://img.shields.io/github/stars/votre-username/gertonargent-v2?style=social)
![GitHub Forks](https://img.shields.io/github/forks/votre-username/gertonargent-v2?style=social)
![GitHub Issues](https://img.shields.io/github/issues/votre-username/gertonargent-v2)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/votre-username/gertonargent-v2)
![License](https://img.shields.io/github/license/votre-username/gertonargent-v2)

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

## 🏆 Reconnaissance

**GèrTonArgent a été reconnu par :**
- 🥇 Hackathon FinTech Abidjan 2025
- 🌟 Featured on Product Hunt
- 📰 Unipod & PNUD

---
## 🎤 **NOUVEAUTÉ : Assistant Vocal "SIKA"** - Implémenté!

### L'Innovation Qui Change Tout

**Sika** est votre assistant financier personnel qui fonctionne exactement comme Siri d'Apple, mais pour vos finances! La grande différence? **Il fonctionne même quand l'app est fermée**.

### Comment Utiliser Sika

1. **Activation** : Allez dans "Assistant IA" > Activez le toggle "Assistant Sika"
2. **Permissions** : Autorisez les permissions microphone et overlay
3. **Utilisation** : Dites simplement **"Sika"** n'importe où sur votre téléphone!

### Exemples d'Utilisation

```
Vous : "Sika"
🟢 [Overlay apparaît avec animation pulsante verte]

Vous : "Puis-je dépenser 50,000 FCFA pour un nouveau téléphone?"

Sika : "Analysons ça ensemble... Tu as 120,000 FCFA de budget restant
ce mois-ci. Cette dépense représente 42% de ton budget. Tu as aussi
un objectif 'Nouveau PC' à 500,000 FCFA dont il reste 200,000 FCFA.
Cette dépense ralentirait cet objectif de 3 semaines.

Mon conseil : Si c'est urgent, vas-y. Sinon, attends le mois prochain
pour être plus confortable financièrement."
```

### Architecture Technique de Sika

#### Services Android Natifs
- **SikaWakeWordService.kt** : Détection continue du mot-clé "Sika" avec Vosk
- **SikaOverlayService.kt** : Interface flottante style Siri
- **MainActivity.kt** : Gestion des permissions et communication Flutter ↔ Native

#### Composants Flutter
- **sika_provider.dart** : Logique métier et communication avec le backend
- **sika_service_provider.dart** : Contrôle des services Android
- **sika_page.dart** : Interface principale de Sika
- **sika_floating_button.dart** : Bouton flottant dans l'app
- **sika_service_toggle.dart** : Toggle pour activer/désactiver le service

### Technologies Utilisées pour Sika

```
🎙️ Vosk (vosk-android:0.3.47)    - Wake word detection offline
🗣️ Android SpeechRecognizer       - Speech-to-Text
🔊 Android TextToSpeech           - Réponses vocales
🪟 System Overlay Window          - Interface flottante
⚡ Foreground Service             - Fonctionnement en arrière-plan
💬 FastAPI Backend                - Analyse IA des requêtes
🧠 GPT Integration (prévu)        - Conversations naturelles
```

### Permissions Requises pour Sika

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

### Fichiers Modifiés/Ajoutés pour Sika

#### Android (Kotlin)
```
android/app/src/main/kotlin/com/example/gertonargent_app/
├── SikaWakeWordService.kt          [NOUVEAU - 450 lignes]
├── SikaOverlayService.kt           [NOUVEAU - 380 lignes]
└── MainActivity.kt                 [MODIFIÉ - Ajout SIKA_CHANNEL]
```

#### Flutter (Dart)
```
lib/features/ai_assistant/
├── presentation/
│   ├── pages/
│   │   └── sika_page.dart                      [NOUVEAU - 450 lignes]
│   └── widgets/
│       ├── sika_floating_button.dart           [NOUVEAU - 250 lignes]
│       └── sika_service_toggle.dart            [NOUVEAU - 125 lignes]
└── providers/
    ├── sika_provider.dart                      [NOUVEAU - 200 lignes]
    └── sika_service_provider.dart              [NOUVEAU - 125 lignes]
```

### Roadmap Sika

#### ✅ Phase 1 - TERMINÉE (Nov 2024)
- [x] Wake word detection avec Vosk
- [x] Service en arrière-plan
- [x] Overlay flottant
- [x] Speech-to-Text
- [x] Text-to-Speech
- [x] Interface Flutter
- [x] Providers Riverpod
- [x] Communication Flutter ↔ Native

#### 🔄 Phase 2 - En Cours (Déc 2024)
- [ ] Intégration GPT pour conversations naturelles
- [ ] Analyse contextuelle des transactions
- [ ] Recommandations intelligentes
- [ ] Historique des conversations
- [ ] Personnalisation de la voix

#### 📅 Phase 3 - Prévue (Jan 2025)
- [ ] Commandes vocales avancées
- [ ] Routines automatiques
- [ ] Intégration calendrier
- [ ] Rappels intelligents
- [ ] Multi-langue (Anglais, Wolof, etc.)

---

**Note**: Sika est une innovation unique qui différencie GèrTonArgent de toutes les autres applications de gestion financière. C'est le premier assistant vocal dédié aux finances personnelles en Afrique!

**Fait avec ❤️ pour l'Afrique 🇨🇮**

*"La meilleure dépense est celle que tu ne fais pas impulsivement"*
