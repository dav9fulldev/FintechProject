# 🧪 Scénarios de Test Sika

Ce guide détaille les étapes pour vérifier le bon fonctionnement de l'assistant vocal Sika.

---

## 🟢 Test 1 : Premier Contact (Happy Path)
**Objectif** : Vérifier que Sika se réveille et comprend une commande simple.

1.  **Réveil** : Dites "**Sika**".
2.  **Attendu** : Sika répond "Oui [Votre Prénom] ?" et la bulle noire apparaît.
3.  **Commande** : "Ajoute 5000 transport".
4.  **Confirmation** : Sika doit répondre : "Très bien [Prénom], j'ai enregistré 5000 FCFA en transport."

---

## 🟡 Test 2 : Synchronisation (Offline-First)
**Objectif** : Vérifier que les dépenses vocales remontent bien dans l'application.

1.  **Action** : Enregistrez une dépense à la voix alors que l'application est fermée.
2.  **Action** : Ouvrez l'application GèrTonArgent.
3.  **Attendu** : Un message ou une mise à jour silencieuse doit confirmer que la transaction a été synchronisée.
4.  **Vérification** : Allez dans l'historique des transactions ; la dépense doit y figurer avec la source "Sika Voice".

---

## 🔴 Test 3 : Gestion des Erreurs
**Objectif** : Vérifier la robustesse du système.

### Cas A : Absence de catégorie
- **Commande** : "Ajoute 2000".
- **Attendu** : Sika enregistre la dépense dans la catégorie "**Autre**".

### Cas B : Montant non reconnu
- **Commande** : "Ajoute beaucoup d'argent".
- **Attendu** : Sika répond "Désolé, je n'ai pas compris votre demande."

---

## 🛡️ Checklist Technique (Post-Installation)

- [ ] **Permissions** : Le micro et l'affichage par-dessus les autres apps sont autorisés.
- [ ] **Service** : Une notification "Sika vous écoute" est visible dans les notifications Android.
- [ ] **Langue** : La reconnaissance est bien configurée sur "Français".
- [ ] **Performance** : Le réveil se fait en moins d'une seconde.

---

## 🛠️ Outil de Debugging
Pour les développeurs, surveillez les logs avec cette commande :
```bash
adb logcat | grep SikaV2
```

*GèrTonArgent — Testé et validé pour votre sérénité financière.*
