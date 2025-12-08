# 🎤 Sika Voice Assistant - Demo Day Guide

## ✨ Fonctionnement pour le Demo Day

### 🚀 Démarrage Automatique
**Sika démarre automatiquement** au lancement de l'application, **SANS nécessiter de connexion**.

### 👤 Mode Hors Ligne (Demo Day)
- **Nom par défaut** : "utilisateur"
- **Stockage** : Toutes les transactions vocales sont enregistrées localement dans `SharedPreferences` (Android)
- **Synchronisation** : Les transactions se synchronisent automatiquement quand l'utilisateur se connecte

### 🎯 Scénario Demo Day

#### 1. Lancer l'application
```bash
flutter run
```

#### 2. Sans se connecter, tester Sika
Dire à voix haute :
> **"Sika"**

Sika répond :
> **"Oui utilisateur ?"**

#### 3. Donner une commande de dépense
Exemples de commandes vocales :

**Exemple 1 - Transport**
```
"J'ai dépensé 500 francs en transport"
```
Sika répond :
> "Très bien utilisateur, j'ai enregistré 500 FCFA en transport."

**Exemple 2 - Alimentation**
```
"J'ai acheté pour 3000 francs de nourriture"
```
Sika répond :
> "Très bien utilisateur, j'ai enregistré 3000 FCFA en alimentation."

**Exemple 3 - Loisirs**
```
"Dépensé 2500 francs en loisirs"
```
Sika répond :
> "Très bien utilisateur, j'ai enregistré 2500 FCFA en loisirs."

#### 4. Vérifier les transactions enregistrées
1. Se connecter à l'application avec un compte
2. Les transactions vocales enregistrées hors ligne se synchronisent **automatiquement**
3. Elles apparaissent dans le tableau de bord avec le badge `🎤 Voix`

### 📱 Catégories Supportées
Sika reconnaît automatiquement ces catégories :

| Mots-clés | Catégorie |
|-----------|-----------|
| nourriture, alimentation, manger, repas, courses | 🍽️ Alimentation |
| transport, taxi, bus, essence, carburant | 🚗 Transport |
| logement, loyer, électricité, eau | 🏠 Logement |
| santé, médecin, pharmacie, médicaments | 💊 Santé |
| loisirs, sortie, cinéma, restaurant | 🎮 Loisirs |
| éducation, école, cours, formation, livres | 📚 Éducation |
| vêtements, habits, chaussures | 👕 Habillement |
| autre (catégorie par défaut) | 📦 Autre |

### 🔄 Architecture Technique

#### Stockage Local
```
SharedPreferences Android
└── pending_transactions (JSONArray)
    └── Transaction {
        amount: int,
        category: string,
        description: string,
        date: ISO8601,
        source: "sika_voice",
        status: "pending"
    }
```

#### Flux de Synchronisation
```
Sika Voice Command
    ↓
Local Storage (SharedPreferences)
    ↓
User Logs In (auth.token != null)
    ↓
Automatic Backend Sync (SikaSync.syncPendingTransactions)
    ↓
Transactions Appear in Dashboard
```

### ⚙️ Configuration Technique

#### Service Natif (Android)
- **Fichier** : `SikaWakeWordServiceV2.kt`
- **Mode** : Foreground Service (toujours actif)
- **Wake Word** : "Sika" (détection simple par pattern matching)
- **TTS** : Synthèse vocale française (fr-FR)
- **STT** : Reconnaissance vocale Google (fr-FR)

#### Initialisation (Flutter)
- **Fichier** : `lib/main.dart`
- **Ligne 27-31** : Démarrage automatique du service
- **Ligne 58** : Log explicite du mode hors-ligne
- **Ligne 67-78** : Synchronisation automatique à la connexion

### 🎯 Points de Démonstration

#### Pour les Invités Non-Connectés
1. ✅ Wake-word "Sika" fonctionne
2. ✅ Reconnaissance vocale française
3. ✅ Réponses TTS personnalisées
4. ✅ Enregistrement local des transactions
5. ✅ Aucune connexion Internet requise

#### Pour les Utilisateurs Connectés
1. ✅ Synchronisation automatique des transactions hors-ligne
2. ✅ Personnalisation avec le prénom de l'utilisateur
3. ✅ Historique complet dans le tableau de bord
4. ✅ Badge "🎤 Voix" pour tracer l'origine

### 🐛 Dépannage

#### Sika ne répond pas
```dart
// Vérifier le service
await SikaNative.isSikaServiceRunning(); // doit retourner true

// Redémarrer manuellement
await SikaNative.stopSikaService();
await SikaNative.startSikaService();
```

#### Les transactions ne se synchronisent pas
```dart
// Forcer la synchronisation
final auth = ref.read(authProvider);
if (auth.token != null) {
  final apiService = ref.read(apiServiceProvider);
  await SikaSync.syncPendingTransactions(apiService: apiService);
}
```

#### Vérifier les transactions locales
```dart
final pending = await SikaNative.readPendingTransactions();
print('Transactions en attente: ${pending.length}');
```

### 📝 Commandes de Test Complètes

```dart
// Test 1: Transport
"Sika" → "J'ai dépensé 1000 francs en transport"

// Test 2: Alimentation
"Sika" → "J'ai acheté 5000 francs de nourriture"

// Test 3: Loisirs
"Sika" → "2000 francs pour le cinéma"

// Test 4: Santé
"Sika" → "J'ai payé 3500 francs chez le médecin"

// Test 5: Éducation
"Sika" → "J'ai acheté des livres pour 7000 francs"
```

### ✅ Checklist Demo Day

- [ ] Application lancée (`flutter run`)
- [ ] Service Sika démarré (vérifier les logs : "✅ Native Sika service started")
- [ ] Test wake-word "Sika" fonctionne
- [ ] Test commande vocale enregistrée
- [ ] Confirmation TTS audible
- [ ] Transaction visible après connexion

### 🎊 Message pour les Invités

> "**Sika** est votre assistant vocal personnel pour GèrTonArgent. 
> Dites simplement **'Sika'**, puis énoncez votre dépense.
> Par exemple : *'J'ai dépensé 500 francs en transport'*.
> 
> Toutes vos transactions vocales sont enregistrées localement,
> puis synchronisées automatiquement quand vous vous connectez !"

---

**Développé avec ❤️ pour le Demo Day**  
*Système de reconnaissance vocale totalement fonctionnel en mode hors-ligne*
