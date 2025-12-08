# Sika - Données d'entraînement et Amélioration

## 📊 Objectif

Améliorer la **naturalité** et la **précision** des réponses vocales de Sika, en particulier pour :
- ✅ Prononciation correcte des **montants en français** (TTS)
- ✅ Réponses **contextuelles et variées** 
- ✅ Compréhension des **montants parlés** (STT)
- ✅ Adaptation au **langage ivoirien**

---

## 🎯 Problèmes Résolus

### 1. **Prononciation des nombres**
❌ **Avant** : TTS dit "5000" → "cinq zéro zéro zéro"  
✅ **Après** : TTS dit "cinq mille francs cfa"

**Solution** : Module `sika_nlp.py` convertit les nombres en mots français

### 2. **Réponses robotiques**
❌ **Avant** : "Transaction enregistrée. Montant: 5000 FCFA"  
✅ **Après** : "Très bien David, j'ai noté cinq mille francs cfa pour transport !"

**Solution** : Templates de réponses variés avec génération aléatoire

### 3. **Manque de contexte**
❌ **Avant** : Réponse identique quel que soit le score budgétaire  
✅ **Après** : Réponses adaptées selon budget (OK / Prudence / Danger)

---

## 📚 Données d'Entraînement

### A. Montants Courants en Côte d'Ivoire (FCFA)

| Montant | En mots | Contexte typique |
|---------|---------|------------------|
| 100 | cent francs cfa | Monnaie, pourboire |
| 200 | deux cents francs cfa | Pain, eau sachet |
| 500 | cinq cents francs cfa | Transport court, café |
| 1000 | mille francs cfa | Taxi-compteur, sandwich |
| 2000 | deux mille francs cfa | Repas simple |
| 5000 | cinq mille francs cfa | Transport longue distance, plat garni |
| 10000 | dix mille francs cfa | Courses alimentaires journée |
| 15000 | quinze mille francs cfa | Essence moto, shopping |
| 25000 | vingt-cinq mille francs cfa | Forfait internet, vêtements |
| 50000 | cinquante mille francs cfa | Courses semaine, loyer modeste |
| 75000 | soixante-quinze mille francs cfa | Facture électricité |
| 100000 | cent mille francs cfa | Salaire mensuel, loyer |
| 250000 | deux cent cinquante mille francs cfa | Scolarité, loyer haut standing |
| 500000 | cinq cent mille francs cfa | Appareil électronique |
| 1000000 | un million de francs cfa | Moto, gros équipement |

### B. Catégories et Vocabulaire Local

| Catégorie | Mots-clés français | Mots ivoiriens | Exemples |
|-----------|-------------------|----------------|----------|
| **Transport** | taxi, bus, essence, moto | gbakas, wôrô-wôrô, gbaka, gazoil | "J'ai pris un wôrô pour 500" |
| **Alimentation** | manger, repas, attieké, riz | garba, attiéké-poisson, allocos | "J'ai acheté un garba à 1000" |
| **Communication** | crédit, internet, forfait | crédit MTN, Orange Money | "J'ai rechargé 5000 de crédit" |
| **Loisirs** | maquis, sortie, cinéma | maquis, go, chill | "On est allés au maquis, 10000" |

### C. Patterns de Commandes Vocales

#### **Ajout de dépense (passé)**
```
✅ "Sika, j'ai dépensé 5000 en transport"
✅ "Sika, j'ai pris un taxi à 2000"
✅ "Sika, j'ai acheté un garba à 1000"
✅ "Sika, j'ai payé 50000 de loyer"
✅ "Sika, j'ai rechargé 5000 de crédit"
✅ "Sika, ajoute 15000 pour les courses"
✅ "Sika, enregistre 10000 en alimentation"
```

#### **Conseil avant achat (futur)**
```
✅ "Sika, je peux dépenser 20000 en loisirs ?"
✅ "Sika, est-ce que je peux acheter des chaussures à 50000 ?"
✅ "Sika, puis-je prendre un taxi à 5000 ?"
```

#### **Solde/Budget**
```
✅ "Sika, combien il me reste ?"
✅ "Sika, quel est mon solde ?"
✅ "Sika, j'ai combien disponible ?"
✅ "Sika, je suis à combien ?"
```

#### **Conseils**
```
✅ "Sika, donne-moi un conseil"
✅ "Sika, qu'est-ce que je dois faire ?"
✅ "Sika, aide-moi"
```

---

## 🎓 Templates de Réponses par Scénario

### 1. **Dépense Enregistrée** (Passé)

#### Score élevé (7-10) : Budget OK ✅
```
"Très bien {firstname}, j'ai enregistré {montant_mots} pour {catégorie}."
"D'accord {firstname}! J'ai noté {montant_mots} en {catégorie}."
"C'est fait {firstname}! {montant_mots} ajoutés en {catégorie}."
"Parfait {firstname}, ta dépense de {montant_mots} en {catégorie} est enregistrée."
"OK {firstname}, j'ai bien noté {montant_mots} pour {catégorie}."
```

#### Score moyen (4-6) : Prudence ⚠️
```
"D'accord {firstname}, j'ai noté {montant_mots} en {catégorie}. Attention à ton budget!"
"J'enregistre {montant_mots} pour {catégorie}. Fais attention, ton budget se resserre."
"C'est noté {firstname}, {montant_mots} en {catégorie}. Reste vigilant sur tes dépenses."
```

#### Score faible (1-3) : Danger 🚫
```
"Aïe {firstname}... j'ai quand même enregistré {montant_mots} en {catégorie}, mais ton budget est vraiment serré!"
"{firstname}, cette dépense de {montant_mots} en {catégorie} est risquée. Fais attention!"
"C'est enregistré {firstname}, mais {montant_mots} en {catégorie}, c'est beaucoup trop là!"
```

### 2. **Conseil Achat Futur**

#### Possible ✅
```
"Oui {firstname}, tu peux dépenser {montant_mots} pour {catégorie}. C'est dans ton budget!"
"Pas de problème {firstname}! {montant_mots} en {catégorie}, c'est raisonnable."
"Vas-y {firstname}, {montant_mots} pour {catégorie} ça passe large!"
```

#### Prudence ⚠️
```
"Hmm {firstname}, {montant_mots} pour {catégorie}... c'est possible mais ça va serrer ton budget."
"Tu peux {firstname}, mais {montant_mots} en {catégorie} c'est limite. Réfléchis bien!"
```

#### Déconseillé 🚫
```
"Stop {firstname}! Tu veux dépenser {montant_mots} mais tu n'as que {reste_mots} disponibles. C'est trop!"
"Je te déconseille vraiment {firstname}. {montant_mots} en {catégorie}, c'est trop risqué!"
```

### 3. **Solde/Budget**

#### Budget OK (< 50% utilisé) ✅
```
"Super {firstname}! Il te reste {reste_mots} sur ton budget de {total_mots}. Tu gères bien!"
"{firstname}, tu as encore {reste_mots} disponibles. Bravo, tu es large!"
```

#### Budget Moyen (50-75%) ⚠️
```
"{firstname}, il te reste {reste_mots} sur {total_mots}. Ça va, tu tiens le coup!"
"Tu as {reste_mots} disponibles {firstname}. C'est gérable!"
```

#### Budget Serré (> 75%) 🚫
```
"Attention {firstname}! Il ne te reste que {reste_mots} sur {total_mots}. Fais gaffe!"
"Aïe {firstname}, seulement {reste_mots} disponibles. Ton budget est serré!"
```

---

## 🛠️ Architecture Technique

### Backend (FastAPI + Python)
```
backend/
├── app/
│   ├── services/
│   │   ├── sika_nlp.py          ← Module NLP (nombres → mots)
│   │   └── ai_engine.py         ← Logique métier
│   └── routes/
│       └── ai.py                ← Endpoints API
│           ├── POST /ai/sika/response      ← Génère réponse naturelle
│           └── POST /ai/sika/parse-command ← Parse commande vocale
```

### Frontend Kotlin (Android)
```kotlin
SikaWakeWordServiceV2.kt
├── Détection wake-word "Sika"
├── TTS: "Oui {firstname}?"
├── STT: Capture commande
├── Parse commande localement (regex)
├── [NEW] Appel API backend pour réponse naturelle
└── TTS: Réponse avec nombres en mots
```

---

## 📊 Exemples Concrets

### Exemple 1 : Ajout Dépense Transport
```
Utilisateur: "Sika"
Sika TTS: "Oui David?"
Utilisateur: "J'ai pris un taxi à 5000"
Sika analyse:
  - Montant: 5000
  - Catégorie: transport
  - Type: expense_past
  - Score: 8 (budget OK)
Sika répond: "Très bien David, j'ai enregistré cinq mille francs cfa pour déplacements."
```

### Exemple 2 : Conseil Avant Achat
```
Utilisateur: "Sika"
Sika TTS: "Oui David?"
Utilisateur: "Je peux acheter des chaussures à 50000?"
Sika analyse:
  - Montant: 50000
  - Catégorie: vetements
  - Type: expense_future
  - Reste: 30000 (budget insuffisant!)
  - Score: 1
Sika répond: "Stop David! Tu veux dépenser cinquante mille francs cfa mais tu n'as que trente mille francs cfa disponibles. C'est trop!"
```

### Exemple 3 : Consultation Solde
```
Utilisateur: "Sika"
Sika TTS: "Bonjour David!"
Utilisateur: "Combien il me reste?"
Sika analyse:
  - Type: balance
  - Budget total: 100000
  - Dépensé: 75000
  - Reste: 25000
  - Usage: 75%
Sika répond: "Attention David! Il ne te reste que vingt-cinq mille francs cfa sur cent mille francs cfa. Fais gaffe!"
```

---

## 🚀 Intégration Kotlin → API Backend

### Modification `SikaWakeWordServiceV2.kt`

Au lieu de générer la réponse localement, appeler l'API :

```kotlin
private fun handleAddExpense(entities: Map<String, String>) {
    val amount = entities["amount"]?.toIntOrNull() ?: return
    val category = entities["category"] ?: "autre"
    val firstname = prefs.getString("user_firstname", "utilisateur") ?: "utilisateur"
    val userId = prefs.getInt("user_id", 1)
    
    // Appeler l'API backend pour obtenir réponse naturelle
    Thread {
        try {
            val response = callSikaResponseAPI(
                userId = userId,
                firstname = firstname,
                commandType = "expense_past",
                amount = amount.toFloat(),
                category = category
            )
            
            // TTS avec la réponse naturelle
            speakAsync(response.responseText)
            
            // Ajouter à pending_transactions
            addPendingTransaction(amount, category, response.scoreData)
            
            Thread.sleep(3000)
            restartWakeWordDetection()
        } catch (e: Exception) {
            Log.e(TAG, "Erreur API: ${e.message}")
            // Fallback local
            speakAsync("Très bien $firstname, j'ai enregistré $amount FCFA en $category.")
            restartWakeWordDetection()
        }
    }.start()
}

private fun callSikaResponseAPI(
    userId: Int,
    firstname: String,
    commandType: String,
    amount: Float?,
    category: String?
): SikaResponse {
    val url = URL("http://192.168.45.203:8000/ai/sika/response")
    val connection = url.openConnection() as HttpURLConnection
    connection.requestMethod = "POST"
    connection.setRequestProperty("Content-Type", "application/json")
    connection.doOutput = true
    
    val jsonInput = JSONObject().apply {
        put("user_id", userId)
        put("firstname", firstname)
        put("command_type", commandType)
        if (amount != null) put("amount", amount)
        if (category != null) put("category", category)
    }
    
    connection.outputStream.use { os ->
        os.write(jsonInput.toString().toByteArray())
    }
    
    val responseCode = connection.responseCode
    if (responseCode == HttpURLConnection.HTTP_OK) {
        val response = connection.inputStream.bufferedReader().readText()
        val json = JSONObject(response)
        return SikaResponse(
            responseText = json.getString("response"),
            scoreData = json.optInt("score", 7)
        )
    } else {
        throw Exception("API Error: $responseCode")
    }
}

data class SikaResponse(
    val responseText: String,
    val scoreData: Int
)
```

---

## 📈 Améliorations Futures

### 1. **Apprentissage des Habitudes**
- Mémoriser les dépenses récurrentes (loyer, transport quotidien)
- Suggérer des montants basés sur l'historique

### 2. **Compréhension Contextuelle**
- "Même montant que hier" → Retrouver la dernière transaction
- "Pour la même chose" → Catégorie précédente

### 3. **Langage Ivoirien Avancé**
- Intégrer le nouchi (argot ivoirien)
- Reconnaître "gbaka", "wôrô", "garba", etc.

### 4. **Proactivité**
- "Attention, tu dépenses beaucoup en transport ce mois-ci"
- "Tu n'as pas épargné cette semaine"

---

## ✅ Checklist Mise en Production

- [x] Module NLP créé (`sika_nlp.py`)
- [x] Endpoints API ajoutés (`/ai/sika/response`, `/ai/sika/parse-command`)
- [x] Tests conversion nombres → mots
- [ ] Intégration Kotlin → API backend
- [ ] Tests bout-en-bout Sika
- [ ] Optimisation cache (éviter appels API répétés)
- [ ] Gestion hors-ligne (fallback local)
- [ ] Ajout langues supplémentaires (anglais, local)

---

## 📞 Test Manuel

1. **Lancer le backend** : `python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000`
2. **Tester API directement** :
```bash
curl -X POST http://192.168.45.203:8000/ai/sika/response \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": 1,
    "firstname": "David",
    "command_type": "expense_past",
    "amount": 5000,
    "category": "transport"
  }'
```

3. **Résultat attendu** :
```json
{
  "response": "Très bien David, j'ai enregistré cinq mille francs cfa pour déplacements.",
  "remaining": 95000,
  "total_budget": 100000,
  "usage_percent": 5.0,
  "score": 8
}
```

---

**Auteur** : Assistant GèrTonArgent  
**Date** : 2025-11-29  
**Version** : 1.0
