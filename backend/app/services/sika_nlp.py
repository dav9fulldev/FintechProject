"""
Sika NLP - Module d'amélioration du langage naturel pour l'assistant vocal Sika

Fonctionnalités:
1. Conversion nombres → mots (pour meilleure prononciation TTS)
2. Génération de réponses naturelles et contextuelles
3. Patterns de conversation basés sur les données réelles
4. Variantes de réponses pour éviter la répétition
"""

import random
from typing import Dict, Any, List, Optional, Tuple


class SikaNLP:
    """Assistant NLP pour des réponses vocales plus naturelles"""

    # ===== CONVERSION NOMBRES → MOTS =====

    ONES = ["", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf"]
    TEENS = ["dix", "onze", "douze", "treize", "quatorze", "quinze", "seize", 
             "dix-sept", "dix-huit", "dix-neuf"]
    TENS = ["", "", "vingt", "trente", "quarante", "cinquante", "soixante", 
            "soixante", "quatre-vingt", "quatre-vingt"]
    
    @staticmethod
    def number_to_words(n: int) -> str:
        """
        Convertit un nombre en mots français pour TTS
        
        Examples:
            5000 → "cinq mille"
            15000 → "quinze mille"
            250 → "deux cent cinquante"
            1500 → "mille cinq cents"
        """
        if n == 0:
            return "zéro"
        
        if n < 0:
            return "moins " + SikaNLP.number_to_words(-n)
        
        # Cas spéciaux FCFA
        if n >= 1000000:
            millions = n // 1000000
            reste = n % 1000000
            result = SikaNLP._convert_hundreds(millions) + " million"
            if millions > 1:
                result += "s"
            if reste > 0:
                result += " " + SikaNLP.number_to_words(reste)
            return result
        
        if n >= 1000:
            thousands = n // 1000
            reste = n % 1000
            if thousands == 1:
                result = "mille"
            else:
                result = SikaNLP._convert_hundreds(thousands) + " mille"
            if reste > 0:
                result += " " + SikaNLP._convert_hundreds(reste)
            return result
        
        return SikaNLP._convert_hundreds(n)
    
    @staticmethod
    def _convert_hundreds(n: int) -> str:
        """Convertit un nombre < 1000"""
        if n == 0:
            return ""
        
        if n < 10:
            return SikaNLP.ONES[n]
        
        if n < 20:
            return SikaNLP.TEENS[n - 10]
        
        if n < 100:
            tens = n // 10
            ones = n % 10
            if tens == 7 or tens == 9:
                # 70-79, 90-99
                result = SikaNLP.TENS[tens]
                if tens == 7:
                    if ones == 1:
                        result += " et onze"
                    else:
                        result += "-" + SikaNLP.TEENS[ones]
                else:  # 90-99
                    result += "-" + SikaNLP.TEENS[ones]
            elif ones == 1 and tens != 8:
                result = SikaNLP.TENS[tens] + " et un"
            elif ones == 0:
                result = SikaNLP.TENS[tens]
                if tens == 8:
                    result += "s"  # quatre-vingts
            else:
                result = SikaNLP.TENS[tens] + "-" + SikaNLP.ONES[ones]
            return result
        
        # 100-999
        hundreds = n // 100
        reste = n % 100
        if hundreds == 1:
            result = "cent"
        else:
            result = SikaNLP.ONES[hundreds] + " cent"
            if reste == 0:
                result += "s"
        
        if reste > 0:
            result += " " + SikaNLP._convert_hundreds(reste)
        
        return result
    
    @staticmethod
    def format_amount_for_speech(amount: float) -> str:
        """
        Formate un montant pour le TTS avec FCFA
        
        Examples:
            5000 → "cinq mille francs cfa"
            15000 → "quinze mille francs cfa"
            250 → "deux cent cinquante francs cfa"
        """
        amount_int = int(amount)
        words = SikaNLP.number_to_words(amount_int)
        return f"{words} francs cfa"

    # ===== CATÉGORIES EN LANGAGE NATUREL =====

    CATEGORY_NAMES = {
        "alimentation": ["alimentation", "nourriture", "repas", "manger"],
        "transport": ["transport", "déplacements", "taxi"],
        "logement": ["logement", "maison", "loyer"],
        "sante": ["santé", "médecin", "soins"],
        "education": ["éducation", "formation", "école"],
        "loisirs": ["loisirs", "divertissement", "sorties"],
        "epargne": ["épargne", "économies"],
        "vetements": ["vêtements", "habits", "shopping"],
        "communication": ["communication", "téléphone", "internet"],
        "autre": ["autres dépenses", "divers"]
    }

    @staticmethod
    def get_category_speech_name(category: str) -> str:
        """Retourne un nom de catégorie naturel pour TTS"""
        variants = SikaNLP.CATEGORY_NAMES.get(category.lower(), [category])
        return random.choice(variants)

    # ===== RÉPONSES CONTEXTUELLES =====

    @staticmethod
    def generate_greeting(firstname: str) -> str:
        """Génère un salut personnalisé"""
        greetings = [
            f"Oui {firstname}?",
            f"Je t'écoute {firstname}",
            f"Oui {firstname}, dis-moi",
            f"Bonjour {firstname}, que puis-je faire pour toi?",
            f"Salut {firstname}!"
        ]
        return random.choice(greetings)

    @staticmethod
    def generate_expense_confirmation(
        firstname: str,
        amount: float,
        category: str,
        score: int
    ) -> str:
        """
        Génère une confirmation d'ajout de dépense naturelle
        
        Args:
            firstname: Prénom de l'utilisateur
            amount: Montant en FCFA
            category: Catégorie de la dépense
            score: Score de recommandation (1-10)
        """
        amount_speech = SikaNLP.format_amount_for_speech(amount)
        category_speech = SikaNLP.get_category_speech_name(category)
        
        if score >= 7:
            # Réponse positive
            templates = [
                f"Très bien {firstname}, j'ai enregistré {amount_speech} pour {category_speech}.",
                f"D'accord {firstname}! J'ai noté {amount_speech} en {category_speech}.",
                f"C'est fait {firstname}! {amount_speech} ajoutés en {category_speech}.",
                f"Parfait {firstname}, ta dépense de {amount_speech} en {category_speech} est enregistrée.",
                f"OK {firstname}, j'ai bien noté {amount_speech} pour {category_speech}."
            ]
        elif score >= 4:
            # Réponse neutre/prudente
            templates = [
                f"D'accord {firstname}, j'ai noté {amount_speech} en {category_speech}. Attention à ton budget!",
                f"J'enregistre {amount_speech} pour {category_speech}. Fais attention, ton budget se resserre.",
                f"C'est noté {firstname}, {amount_speech} en {category_speech}. Reste vigilant sur tes dépenses.",
                f"OK {firstname}, {amount_speech} pour {category_speech}. N'oublie pas de surveiller ton budget."
            ]
        else:
            # Réponse critique
            templates = [
                f"Aïe {firstname}... j'ai quand même enregistré {amount_speech} en {category_speech}, mais ton budget est vraiment serré!",
                f"{firstname}, cette dépense de {amount_speech} en {category_speech} est risquée. Fais attention!",
                f"Je note {amount_speech} pour {category_speech}, mais vraiment {firstname}, ton budget va souffrir.",
                f"C'est enregistré {firstname}, mais {amount_speech} en {category_speech}, c'est beaucoup trop là!"
            ]
        
        return random.choice(templates)

    @staticmethod
    def generate_purchase_advice(
        firstname: str,
        amount: float,
        category: str,
        remaining: float,
        score: int
    ) -> str:
        """
        Génère un conseil pour un achat futur
        
        Args:
            firstname: Prénom de l'utilisateur
            amount: Montant envisagé
            category: Catégorie
            remaining: Budget restant
            score: Score de recommandation (1-10)
        """
        amount_speech = SikaNLP.format_amount_for_speech(amount)
        category_speech = SikaNLP.get_category_speech_name(category)
        remaining_speech = SikaNLP.format_amount_for_speech(remaining)
        
        if amount > remaining:
            # Impossible
            templates = [
                f"Stop {firstname}! Tu veux dépenser {amount_speech} mais tu n'as que {remaining_speech} disponibles. C'est trop!",
                f"Attention {firstname}, {amount_speech} en {category_speech}? Tu n'as que {remaining_speech}! Je te déconseille vraiment.",
                f"Non {firstname}, {amount_speech} c'est impossible. Il te reste seulement {remaining_speech}.",
                f"{firstname}, désolé mais {amount_speech} ça dépasse ton budget. Tu as {remaining_speech} disponibles."
            ]
        elif score >= 7:
            # OK
            templates = [
                f"Oui {firstname}, tu peux dépenser {amount_speech} pour {category_speech}. C'est dans ton budget!",
                f"Pas de problème {firstname}! {amount_speech} en {category_speech}, c'est raisonnable.",
                f"Vas-y {firstname}, {amount_speech} pour {category_speech} ça passe large!",
                f"Aucun souci {firstname}. {amount_speech} en {category_speech}, c'est gérable."
            ]
        elif score >= 4:
            # Prudence
            templates = [
                f"Hmm {firstname}, {amount_speech} pour {category_speech}... c'est possible mais ça va serrer ton budget.",
                f"Tu peux {firstname}, mais {amount_speech} en {category_speech} c'est limite. Réfléchis bien!",
                f"{firstname}, {amount_speech} pour {category_speech}? C'est faisable mais prudence!",
                f"Techniquement oui {firstname}, mais {amount_speech} en {category_speech} va impacter ton budget."
            ]
        else:
            # Déconseillé
            templates = [
                f"Je te déconseille vraiment {firstname}. {amount_speech} en {category_speech}, c'est trop risqué pour ton budget!",
                f"Non {firstname}, {amount_speech} pour {category_speech}? C'est une mauvaise idée. Ton budget est déjà serré.",
                f"{firstname}, évite cette dépense de {amount_speech} en {category_speech}. Ton budget va en souffrir!",
                f"Vraiment pas recommandé {firstname}. {amount_speech} en {category_speech}, c'est beaucoup trop."
            ]
        
        return random.choice(templates)

    @staticmethod
    def generate_balance_response(
        firstname: str,
        remaining: float,
        total_budget: float,
        usage_percent: float
    ) -> str:
        """Génère une réponse sur le solde disponible"""
        remaining_speech = SikaNLP.format_amount_for_speech(remaining)
        total_speech = SikaNLP.format_amount_for_speech(total_budget)
        
        if usage_percent < 50:
            templates = [
                f"Super {firstname}! Il te reste {remaining_speech} sur ton budget de {total_speech}. Tu gères bien!",
                f"{firstname}, tu as encore {remaining_speech} disponibles. Bravo, tu es large!",
                f"Excellent {firstname}! {remaining_speech} restants sur {total_speech}. Continue comme ça!",
                f"Nickel {firstname}, {remaining_speech} sur {total_speech}. Tu es à l'aise!"
            ]
        elif usage_percent < 75:
            templates = [
                f"{firstname}, il te reste {remaining_speech} sur {total_speech}. Ça va, tu tiens le coup!",
                f"Tu as {remaining_speech} disponibles {firstname}. C'est gérable!",
                f"{firstname}, {remaining_speech} restants sur ton budget de {total_speech}. Prudence quand même!",
                f"Pas mal {firstname}, encore {remaining_speech} sur {total_speech}."
            ]
        else:
            templates = [
                f"Attention {firstname}! Il ne te reste que {remaining_speech} sur {total_speech}. Fais gaffe!",
                f"Aïe {firstname}, seulement {remaining_speech} disponibles. Ton budget est serré!",
                f"{firstname}, il te reste {remaining_speech}. C'est limite, fais attention!",
                f"Prudence {firstname}! Plus que {remaining_speech} sur {total_speech}. Surveille tes dépenses!"
            ]
        
        return random.choice(templates)

    @staticmethod
    def generate_error_response(firstname: str, error_type: str = "general") -> str:
        """Génère une réponse d'erreur naturelle"""
        if error_type == "no_amount":
            templates = [
                f"Désolé {firstname}, je n'ai pas compris le montant. Répète s'il te plaît?",
                f"{firstname}, tu peux me redire le montant? Je n'ai pas saisi.",
                f"Pardon {firstname}, quel montant exactement?",
                f"Je n'ai pas compris le montant {firstname}. Combien?"
            ]
        elif error_type == "not_understood":
            templates = [
                f"Désolé {firstname}, je n'ai pas bien compris. Tu peux reformuler?",
                f"Pardon {firstname}, répète s'il te plaît?",
                f"Je n'ai pas saisi {firstname}. Redis-moi ça?",
                f"{firstname}, je n'ai pas compris. Qu'est-ce que tu veux?"
            ]
        else:
            templates = [
                f"Oups {firstname}, une erreur s'est produite. Réessaie!",
                f"Désolé {firstname}, problème technique. Redemande-moi!",
                f"{firstname}, ça a buggé. Relance-moi!",
                f"Erreur {firstname}. Retente ta chance!"
            ]
        
        return random.choice(templates)

    @staticmethod
    def generate_advice(
        firstname: str,
        usage_percent: float,
        worst_category: Optional[Dict[str, Any]] = None
    ) -> str:
        """Génère un conseil personnalisé"""
        if worst_category and worst_category.get("usage", 0) > 80:
            category_speech = SikaNLP.get_category_speech_name(worst_category["name"])
            templates = [
                f"{firstname}, attention! Ta catégorie {category_speech} est à {worst_category['usage']:.0f}%. Ralentis là-dessus!",
                f"Conseil {firstname}: tu as déjà dépensé {worst_category['usage']:.0f}% en {category_speech}. Freine un peu!",
                f"{firstname}, {category_speech} explose ton budget! Tu es à {worst_category['usage']:.0f}%. Fais gaffe!"
            ]
        elif usage_percent < 50:
            templates = [
                f"Bravo {firstname}! Tu gères super bien. Continue et pense à épargner!",
                f"Excellent {firstname}! Tu es large. Profites-en pour mettre de côté!",
                f"{firstname}, tu es au top! Économise le surplus pour tes objectifs!"
            ]
        elif usage_percent < 75:
            templates = [
                f"{firstname}, tu t'en sors bien. Continue comme ça et évite les achats impulsifs!",
                f"Pas mal {firstname}! Reste prudent et limite les dépenses non essentielles.",
                f"{firstname}, c'est gérable. Fais attention aux petites dépenses qui s'accumulent!"
            ]
        else:
            templates = [
                f"Attention {firstname}! Ton budget est serré. Priorise les dépenses essentielles!",
                f"{firstname}, c'est chaud! Limite-toi au strict nécessaire maintenant.",
                f"Prudence {firstname}! Évite tout achat non urgent jusqu'à la fin du mois!"
            ]
        
        return random.choice(templates)

    # ===== AMÉLIORATION DES COMMANDES VOCALES =====

    @staticmethod
    def improve_stt_text(text: str) -> str:
        """
        Améliore le texte reconnu par STT (corrections courantes)
        
        Examples:
            "5000 franco" → "5000 francs"
            "5 milliers" → "5000"
            "15 1000" → "15000"
        """
        # Corrections courantes STT français
        corrections = {
            "franco": "francs",
            "francfort": "francs",
            "cfa": "francs cfa",
            "milliers": "mille",
            "millier": "mille",
            "milles": "mille",
        }
        
        text_lower = text.lower()
        for wrong, correct in corrections.items():
            text_lower = text_lower.replace(wrong, correct)
        
        return text_lower


# ===== EXEMPLE D'UTILISATION =====

if __name__ == "__main__":
    nlp = SikaNLP()
    
    # Test conversion nombres
    print("=== TESTS CONVERSION NOMBRES ===")
    test_amounts = [5000, 15000, 250, 1500, 75000, 100000, 1000000]
    for amount in test_amounts:
        print(f"{amount} → {nlp.format_amount_for_speech(amount)}")
    
    print("\n=== TESTS RÉPONSES ===")
    # Test confirmation
    print(nlp.generate_expense_confirmation("David", 5000, "transport", 8))
    print(nlp.generate_expense_confirmation("David", 50000, "loisirs", 3))
    
    # Test conseil achat
    print(nlp.generate_purchase_advice("David", 15000, "alimentation", 50000, 7))
    print(nlp.generate_purchase_advice("David", 60000, "vetements", 50000, 2))
    
    # Test solde
    print(nlp.generate_balance_response("David", 75000, 100000, 25))
    print(nlp.generate_balance_response("David", 10000, 100000, 90))
