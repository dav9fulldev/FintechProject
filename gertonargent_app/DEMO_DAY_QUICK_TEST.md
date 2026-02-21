# 🎯 Test Rapide Sika - Demo Day

## 🚀 Commandes de Test (30 secondes)

### Test 1 : Wake Word
```
Dire : "Sika"
Attendu : "Oui utilisateur ?"
```

### Test 2 : Transport
```
Dire : "J'ai dépensé 500 francs en transport"
Attendu : "Très bien utilisateur, j'ai enregistré 500 FCFA en transport."
```

### Test 3 : Alimentation
```
Dire : "Sika"
Puis : "J'ai acheté 3000 francs de nourriture"
Attendu : "Très bien utilisateur, j'ai enregistré 3000 FCFA en alimentation."
```

### Test 4 : Loisirs
```
Dire : "Sika"
Puis : "2500 francs en loisirs"
Attendu : "Très bien utilisateur, j'ai enregistré 2500 FCFA en loisirs."
```

## ✅ Vérification Post-Test

### Étape 1 : Vérifier les transactions locales
```dart
final pending = await SikaNative.readPendingTransactions();
print('${pending.length} transactions en attente'); // doit afficher 3
```

### Étape 2 : Se connecter et vérifier la synchronisation
1. Se connecter avec n'importe quel compte
2. Observer les logs : "User logged in, syncing offline transactions to backend"
3. Ouvrir le Dashboard
4. Vérifier que les 3 transactions apparaissent avec le badge 🎤

## 🎤 Phrases d'Exemple pour le Public

### Démonstration Complète (2 minutes)
```
"Bonjour, je vais vous montrer Sika, notre assistant vocal."

[Dire à voix haute] "Sika"
→ [App répond] "Oui utilisateur ?"

"J'ai dépensé 1000 francs en transport ce matin"
→ [App répond] "Très bien utilisateur, j'ai enregistré 1000 FCFA en transport."

[Attendre 3 secondes]

[Dire à voix haute] "Sika"
→ [App répond] "Oui utilisateur ?"

"J'ai acheté pour 5000 francs de nourriture"
→ [App répond] "Très bien utilisateur, j'ai enregistré 5000 FCFA en alimentation."

[Se connecter à l'application]

"Comme vous pouvez le voir, mes transactions vocales 
sont maintenant synchronisées dans le tableau de bord, 
avec le badge 🎤 pour indiquer qu'elles viennent de Sika."
```

## 🔥 Points Forts à Mettre en Avant

1. **"Fonctionne sans connexion"** - Pas besoin de compte ni d'Internet
2. **"Reconnaissance vocale en français"** - Adapté au contexte africain francophone
3. **"Synchronisation automatique"** - Les données ne sont jamais perdues
4. **"Wake-word personnalisé 'Sika'"** - Pas besoin d'ouvrir l'app
5. **"Catégorisation intelligente"** - Reconnaît automatiquement les catégories

## ⚡ Backup Plan (Si problème technique)

### Si le micro ne marche pas
```
"Sika est un assistant vocal qui vous permet d'enregistrer 
vos dépenses simplement en parlant. Normalement, vous diriez 
'Sika', puis votre dépense comme 'J'ai dépensé 500 francs 
en transport', et l'app enregistre automatiquement."
```

### Si la reconnaissance échoue
```
"La reconnaissance vocale nécessite parfois un environnement 
calme. Dans un contexte réel, Sika fonctionne très bien 
avec une prononciation claire."
```

## 📱 Statistiques à Mentionner

- ✅ **100% hors ligne** - Aucune connexion Internet requise
- ✅ **8 catégories** automatiques (alimentation, transport, logement, santé, loisirs, éducation, habillement, autre)
- ✅ **Français** - Reconnaissance vocale en langue française
- ✅ **0 latence** - Traitement local sur l'appareil
- ✅ **Synchronisation** automatique dès connexion

## 🎯 Script Demo Day (1 minute)

```
[Ouvrir l'application, rester sur la page de login/splash]

"GèrTonArgent intègre Sika, un assistant vocal intelligent."

[Dire à voix haute] "Sika"
→ [App] "Oui utilisateur ?"

"J'ai dépensé 2000 francs en transport"
→ [App] "Très bien utilisateur, j'ai enregistré 2000 FCFA en transport."

"Comme vous voyez, pas besoin d'ouvrir l'application ou 
de saisir manuellement. Sika écoute en arrière-plan, 
reconnaît la catégorie automatiquement, et enregistre 
tout localement. Quand je me connecte..."

[Se connecter]

"... mes transactions vocales se synchronisent automatiquement 
avec le cloud. C'est particulièrement utile en Afrique où 
Internet n'est pas toujours disponible."
```

---

**Durée totale : ~60 secondes**  
**Impact : Maximum** 🚀
