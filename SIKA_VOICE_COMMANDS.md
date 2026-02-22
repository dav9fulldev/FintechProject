# 🎙️ Commandes Vocales Sika

Sika est conçu pour comprendre des intentions naturelles liées à la gestion de vos finances. Voici comment interagir avec votre assistant.

---

## 🔑 Activer Sika
Dites simplement "**Sika**" à voix haute.
- **Réponse attendue** : "Oui [Votre Prénom] ?"
- **Indicateur visuel** : Une bulle noire animée apparaît à l'écran.

---

## 💰 Enregistrer une Dépense (V2)
C'est la fonction principale de Sika. Vous pouvez être précis ou rapide.

### ✅ Exemples validés :
- "Ajoute **5000** en **transport**"
- "Enregistre **10 mille** pour **repas**"
- "Nouvelle dépense de **2500** taxi"
- "Ajouter **1500** carburant"

### 📂 Catégories reconnues (Mots-clés) :
Sika classe automatiquement vos dépenses en repérant ces mots-clés :
- **Transport** : taxi, bus, voiture, trajet, transport
- **Repas** : manger, restaurant, nourriture, bouffe, repas
- **Carburant** : essence, gazole, fuel, carburant
- **Shopping** : courses, vêtements, habits, marché
- **Services** : coiffure, lavage, blanchisserie
- **Santé** : pharmacie, médecin, hôpital
- **Loisirs** : cinéma, sport, jeux

> [!TIP]
> Si vous ne précisez pas de catégorie ou si le mot n'est pas reconnu, Sika enregistrera la dépense dans "**Autre**".

---

## 🏗️ Structure des Phrases
Sika utilise une détection par expressions régulières (Regex) pour extraire :
1.  **Le Montant** : Il comprend les chiffres (ex: 5000) et les abréviations comme "mille" ou "k" (ex: "10k").
2.  **La Catégorie** : Il cherche un mot-clé dans la liste ci-dessus.

---

## 🔄 Confirmation & Synchronisation
1.  **TTS (Synthèse Vocale)** : Sika confirme : *"Très bien [Prénom], j'ai enregistré [Montant] FCFA en [Catégorie]."*
2.  **Sauvegarde Locale** : La transaction est stockée dans les `SharedPreferences` du téléphone.
3.  **Synchro Automatique** : Dès que l'application GèrTonArgent passe au premier plan, elle synchronise ces données avec le serveur.

---

## 🛠️ Debugging des Commandes
Si Sika ne répond pas correctement :
- **Microphone** : Vérifiez que l'application est autorisée à utiliser le micro.
- **Volume** : Assurez-vous que le son du téléphone est activé pour entendre la réponse.
- **Bruit** : Un environnement très bruyant peut gêner la détection du mot-clé.

> [!IMPORTANT]
> Pour les développeurs, utilisez `adb logcat | grep "SikaV2"` pour voir en temps réel ce que Sika comprend.

---
*GèrTonArgent — La voix au service de votre budget.*
