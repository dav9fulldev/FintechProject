"""
Sika AI Service - LLM conversationnel intelligent

Utilise OpenAI GPT-4 (ou modèle local Llama) pour:
- Répondre en langage naturel (français/nouchi ivoirien)
- Analyser contexte financier personnel
- Donner conseils adaptés à la Côte d'Ivoire
- Personnaliser selon historique utilisateur
"""

import os
import json
import logging
from typing import List, Dict, Optional
from datetime import datetime
import openai
import httpx
from .financial_brain import FinancialBrain

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("SikaAI")


class SikaAI:
    """Service IA conversationnel de Sika"""
    
    # Contexte de base pour Sika
    SYSTEM_PROMPT = """Tu es Sika, l'assistant financier intelligent de GèrTonArgent en Côte d'Ivoire.

PERSONNALITÉ:
- Tu es sympathique, encourageant et parles en français simple
- Tu peux utiliser des expressions ivoiriennes (nouchi) pour créer de la proximité
- Tu donnes des conseils pratiques adaptés au contexte ivoirien
- Tu es honnête: si tu détectes un danger financier, tu le dis clairement

RÔLE:
- Analyser les dépenses et détecter les risques (impulsif, surendettement)
- Proposer des budgets personnalisés selon le revenu
- Donner des alertes proactives (dépassement, fin de mois difficile)
- Conseiller sur l'épargne et l'investissement (BRVM future feature)
- Encourager les bons comportements financiers

CONTEXTE CÔTE D'IVOIRE:
- Monnaie: Franc CFA (FCFA)
- Salaire moyen urbain: 100,000 - 300,000 FCFA
- Coût de vie: Transport 30k, Logement 50-150k, Alimentation 60-100k
- Culture mobile money: Orange Money, Wave, MTN Money très utilisés
- Épargne tontines populaire

STYLE DE RÉPONSE:
- Concis et clair (max 3-4 phrases)
- Utilise des emojis pour rendre dynamique
- Commence souvent par le prénom de l'utilisateur si fourni
- Donne des chiffres FCFA arrondis
- Propose toujours une action concrète

EXEMPLES:
User: "J'ai dépensé 25 000 sur un pantalon"
Sika: "Ehn {prénom}! 25 000 FCFA pour un pantalon, c'est vraiment beaucoup là 😅. C'est 8% de ton revenu du mois! Tu peux trouver moins cher au marché Adjamé. Pense à tes objectifs d'abord 💪"

User: "Je veux économiser pour un voyage"
Sika: "{prénom}, c'est super! 🎉 Dis-moi: c'est pour quand et combien tu veux mettre de côté? Je vais te faire un plan d'épargne automatique."

Réponds toujours de façon adaptée aux DONNÉES FINANCIÈRES que je te fournis."""

    def __init__(self, api_key: Optional[str] = None):
        """
        Initialise Sika AI avec le provider choisi dans le .env
        """
        self.provider = os.getenv("AI_PROVIDER", "openai").lower()
        self.api_key = api_key or os.getenv("OPENAI_API_KEY")
        
        # Ollama config
        self.ollama_base_url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")
        self.ollama_model = os.getenv("OLLAMA_MODEL", "llama3")
        
        print(f"[SikaAI] Initialisé avec le provider : {self.provider.upper()}")
        logger.info(f"Initialise avec le provider : {self.provider.upper()}")
        
        if self.provider == "openai" and self.api_key:
            openai.api_key = self.api_key
            self.model = "gpt-4"
            self.use_openai = True
        elif self.provider == "ollama":
            self.use_openai = False
            self.model = self.ollama_model
        else:
            # Fallback: Réponses basiques sans LLM
            self.use_openai = False
            logger.warning(f"Provider {self.provider} non configure ou cle absente - fallback basique")
    
    async def chat(
        self,
        user_message: str,
        financial_context: Dict,
        conversation_history: List[Dict] = None,
        user_firstname: str = "l'ami"
    ) -> Dict:
        """
        Conversation intelligente avec Sika
        """
        logger.info(f"Requete via {self.provider.upper()} | Modele: {self.model}")
        
        if self.provider == "openai" and self.use_openai:
            return await self._chat_with_gpt(
                user_message,
                financial_context,
                conversation_history,
                user_firstname
            )
        elif self.provider == "ollama":
            return await self._chat_with_ollama(
                user_message,
                financial_context,
                conversation_history,
                user_firstname
            )
        else:
            return self._chat_basic(
                user_message,
                financial_context,
                user_firstname
            )
    
    async def _chat_with_gpt(
        self,
        user_message: str,
        financial_context: Dict,
        conversation_history: List[Dict],
        user_firstname: str
    ) -> Dict:
        """Chat avec GPT-4"""
        try:
            # Construire le contexte financier enrichi
            context_summary = self._build_financial_summary(financial_context, user_firstname)
            
            # Historique de conversation
            messages = [{"role": "system", "content": self.SYSTEM_PROMPT}]
            
            # Ajouter contexte financier comme message système
            messages.append({
                "role": "system",
                "content": f"DONNÉES FINANCIÈRES ACTUELLES:\n{context_summary}"
            })
            
            # Ajouter historique
            if conversation_history:
                messages.extend(conversation_history[-6:])  # Garde les 6 derniers messages
            
            # Ajouter message utilisateur
            messages.append({"role": "user", "content": user_message})
            
            # Appel OpenAI
            response = openai.ChatCompletion.create(
                model=self.model,
                messages=messages,
                temperature=0.7,
                max_tokens=300,
            )
            
            sika_response = response.choices[0].message.content.strip()
            return self._format_response(sika_response, user_message, financial_context)
            
        except Exception as e:
            logger.error(f"OpenAI error: {e}")
            return self._chat_basic(user_message, financial_context, user_firstname)

    async def _chat_with_ollama(
        self,
        user_message: str,
        financial_context: Dict,
        conversation_history: List[Dict],
        user_firstname: str
    ) -> Dict:
        """Chat avec Ollama API (/api/chat)"""
        try:
            context_summary = self._build_financial_summary(financial_context, user_firstname)
            
            messages = [{"role": "system", "content": self.SYSTEM_PROMPT}]
            messages.append({
                "role": "system",
                "content": f"DONNÉES FINANCIÈRES ACTUELLES:\n{context_summary}"
            })
            
            if conversation_history:
                messages.extend(conversation_history[-6:])
            
            messages.append({"role": "user", "content": user_message})
            
            async with httpx.AsyncClient(timeout=60.0) as client:
                response = await client.post(
                    f"{self.ollama_base_url}/api/chat",
                    json={
                        "model": self.model,
                        "messages": messages,
                        "stream": False,
                        "options": {
                            "temperature": 0.7,
                            "num_predict": 300
                        }
                    }
                )
                
                if response.status_code != 200:
                    logger.error(f"Ollama error: {response.status_code} - {response.text}")
                    return self._chat_basic(user_message, financial_context, user_firstname)
                
                result = response.json()
                sika_response = result.get("message", {}).get("content", "").strip()
                
                return self._format_response(sika_response, user_message, financial_context)
                
        except Exception as e:
            logger.error(f"Ollama connection error: {e}")
            return self._chat_basic(user_message, financial_context, user_firstname)

    def _format_response(self, sika_response: str, user_message: str, financial_context: Dict) -> Dict:
        """Helper pour formater la réponse IA"""
        action, action_data = self._extract_action(sika_response, user_message)
        sentiment = self._detect_sentiment(sika_response)
        suggestions = self._generate_suggestions(financial_context)
        
        return {
            "response": sika_response,
            "action": action,
            "action_data": action_data,
            "sentiment": sentiment,
            "suggestions": suggestions
        }
    
    def _chat_basic(
        self,
        user_message: str,
        financial_context: Dict,
        user_firstname: str
    ) -> Dict:
        """Réponses basiques sans LLM (fallback)"""
        message_lower = user_message.lower()
        
        # Détection intentions simples
        if any(word in message_lower for word in ["budget", "combien", "reste"]):
            prediction = financial_context.get("end_of_month_prediction", {})
            remaining = prediction.get("remaining_budget", 0)
            return {
                "response": f"{user_firstname}, il te reste {remaining:.0f} FCFA ce mois-ci 💰",
                "action": None,
                "sentiment": "positive" if remaining > 0 else "warning",
                "suggestions": ["Voir mes dépenses", "Ajuster mon budget"]
            }
        
        elif any(word in message_lower for word in ["dépense", "dépensé", "acheté"]):
            return {
                "response": f"Ok {user_firstname}, dis-moi: c'était combien et pour quoi? 📝",
                "action": "add_transaction",
                "sentiment": "neutral",
                "suggestions": ["Ajouter une dépense", "Voir l'historique"]
            }
        
        elif any(word in message_lower for word in ["économiser", "épargner", "mettre de côté"]):
            return {
                "response": f"Super {user_firstname}! 🎯 L'épargne c'est la clé. Tu veux économiser combien par mois?",
                "action": "set_goal",
                "sentiment": "positive",
                "suggestions": ["Créer un objectif d'épargne", "Voir mes objectifs"]
            }
        
        elif any(word in message_lower for word in ["conseil", "aide", "que faire"]):
            recommendations = financial_context.get("recommendations", [])
            if recommendations:
                top_rec = recommendations[0]
                return {
                    "response": f"{user_firstname}, voici mon conseil: {top_rec.get('message', 'Continue comme ça!')} 💡",
                    "action": None,
                    "sentiment": "warning" if top_rec.get("type") == "urgent" else "positive",
                    "suggestions": ["Voir toutes les recommandations", "Ajuster mon budget"]
                }
            else:
                return {
                    "response": f"Tu gères bien {user_firstname}! Continue comme ça 🎉",
                    "action": None,
                    "sentiment": "positive",
                    "suggestions": ["Voir mon analyse", "Définir un objectif"]
                }
        
        else:
            # Réponse générique
            return {
                "response": f"Salut {user_firstname}! Je suis Sika ton assistant financier 🤖 Comment je peux t'aider aujourd'hui?",
                "action": None,
                "sentiment": "neutral",
                "suggestions": [
                    "Combien il me reste?",
                    "Ajouter une dépense",
                    "Mes conseils du jour"
                ]
            }
    
    def _build_financial_summary(self, context: Dict, user_firstname: str) -> str:
        """Construit un résumé financier pour le LLM"""
        summary_parts = []
        
        # User info
        user = context.get("user", {})
        summary_parts.append(f"Utilisateur: {user_firstname}")
        
        if user.get("monthly_income"):
            summary_parts.append(f"Revenu mensuel: {user['monthly_income']:.0f} FCFA")
        
        # Debt risk
        debt_risk = context.get("debt_risk", {})
        if debt_risk:
            summary_parts.append(f"Risque endettement: {debt_risk.get('risk_level', 'inconnu')}")
            summary_parts.append(f"Dépenses ce mois: {debt_risk.get('monthly_spending', 0):.0f} FCFA")
            summary_parts.append(f"Reste: {debt_risk.get('remaining_income', 0):.0f} FCFA")
        
        # Predictions
        prediction = context.get("end_of_month_prediction", {})
        if prediction:
            summary_parts.append(f"Prévision fin mois: {prediction.get('status', 'inconnu')}")
            summary_parts.append(f"Budget journalier conseillé: {prediction.get('daily_budget_recommendation', 0):.0f} FCFA")
        
        # Patterns
        patterns = context.get("spending_patterns", {})
        if patterns:
            summary_parts.append(f"Dépense moyenne/jour: {patterns.get('daily_average', 0):.0f} FCFA")
            top_cat = patterns.get('top_category')
            if top_cat:
                summary_parts.append(f"Catégorie principale: {top_cat}")
        
        # Top recommendations
        recommendations = context.get("recommendations", [])
        if recommendations:
            top_3 = recommendations[:3]
            summary_parts.append("Alertes importantes:")
            for rec in top_3:
                summary_parts.append(f"- {rec.get('title', '')}: {rec.get('message', '')}")
        
        return "\n".join(summary_parts)
    
    def _extract_action(self, response: str, user_message: str) -> tuple:
        """Détecte si Sika suggère une action"""
        response_lower = response.lower()
        message_lower = user_message.lower()
        
        # Détection d'intention d'ajouter une transaction
        if any(word in message_lower for word in ["j'ai dépensé", "j'ai acheté", "j'ai payé"]):
            # Essayer d'extraire montant et catégorie du message
            return ("add_transaction", {})
        
        if "objectif" in response_lower or "épargne" in response_lower:
            return ("set_goal", {})
        
        if "budget" in response_lower and "ajust" in response_lower:
            return ("adjust_budget", {})
        
        if "voir" in response_lower or "consulte" in response_lower:
            if "dépense" in response_lower:
                return ("view_transactions", {})
            elif "budget" in response_lower:
                return ("view_budget", {})
        
        return (None, None)
    
    def _detect_sentiment(self, response: str) -> str:
        """Détecte le sentiment de la réponse"""
        response_lower = response.lower()
        
        # Sentiments critiques
        if any(word in response_lower for word in ["danger", "alerte", "🔴", "attention!", "risque"]):
            return "critical"
        
        # Sentiments d'avertissement
        if any(word in response_lower for word in ["⚠️", "attention", "prudent", "fais gaffe"]):
            return "warning"
        
        # Sentiments positifs
        if any(word in response_lower for word in ["bravo", "super", "excellent", "🎉", "💪", "✅"]):
            return "positive"
        
        return "neutral"
    
    def _generate_suggestions(self, financial_context: Dict) -> List[str]:
        """Génère des suggestions d'actions rapides"""
        suggestions = []
        
        debt_risk = financial_context.get("debt_risk", {})
        if debt_risk.get("risk_level") in ["high", "critical"]:
            suggestions.append("📊 Voir mes dépenses du mois")
            suggestions.append("✂️ Réduire mes budgets")
        else:
            suggestions.append("💰 Ajouter une dépense")
            suggestions.append("📈 Voir mon analyse")
        
        prediction = financial_context.get("end_of_month_prediction", {})
        if prediction.get("risk_level") == "high":
            suggestions.append("⚠️ Plan d'urgence fin de mois")
        else:
            suggestions.append("🎯 Définir un objectif")
        
        return suggestions[:3]  # Max 3 suggestions
    
    # ========================================================================
    # ANALYSE PROACTIVE (pour alertes automatiques)
    # ========================================================================
    
    def analyze_transaction_before_save(
        self,
        amount: float,
        category: str,
        financial_brain: FinancialBrain
    ) -> Dict:
        """
        Analyse une transaction AVANT de la sauvegarder
        Retourne un warning si problème détecté
        """
        # Détection achat impulsif
        impulsive_check = financial_brain.detect_impulsive_purchase(amount)
        
        if impulsive_check["is_impulsive"]:
            severity = impulsive_check["severity"]
            user_name = financial_brain.user.first_name if financial_brain.user else "l'ami"
            
            if severity == "high":
                message = f"🛑 STOP {user_name}! {impulsive_check['reason']}. {impulsive_check['suggestion']}"
                block_transaction = True
            else:
                message = f"⚠️ {impulsive_check['reason']}. {impulsive_check['suggestion']}"
                block_transaction = False
            
            return {
                "warning": True,
                "block": block_transaction,
                "severity": severity,
                "message": message,
                "risk_score": impulsive_check["risk_score"],
                "allow_override": True  # L'user peut forcer
            }
        
        # Vérification budget catégorie
        category_analysis = financial_brain.analyze_category_spending(category)
        
        if category_analysis["status"] in ["warning", "critical"]:
            return {
                "warning": True,
                "block": False,
                "severity": "medium",
                "message": f"💡 {category_analysis['warning']}. Reste {category_analysis['remaining']:.0f} FCFA.",
                "risk_score": 5,
                "allow_override": True
            }
        
        # Tout est ok
        return {
            "warning": False,
            "message": "Transaction validée ✅"
        }
    
    def generate_daily_insights(self, financial_brain: FinancialBrain, user_firstname: str) -> str:
        """Génère un message de conseil quotidien"""
        analysis = financial_brain.get_full_financial_analysis()
        
        # Message personnalisé selon situation
        debt_risk = analysis["debt_risk"]
        prediction = analysis["end_of_month_prediction"]
        
        if debt_risk["risk_level"] == "critical":
            return f"🚨 {user_firstname}, tu es en danger financier! Tu as dépensé {debt_risk['spending_ratio']:.0f}% de ton revenu. Arrête toutes les dépenses non essentielles immédiatement."
        
        elif debt_risk["risk_level"] == "high":
            return f"⚠️ {user_firstname}, attention! Il te reste seulement {debt_risk['remaining_income']:.0f} FCFA pour {prediction['days_remaining']} jours. Maximum {prediction['daily_budget_recommendation']:.0f} FCFA/jour."
        
        elif prediction["risk_level"] == "high":
            return f"💡 {user_firstname}, tu vas trop vite! Ralentis les dépenses sinon tu vas finir le mois dans le rouge. Budget conseillé: {prediction['daily_budget_recommendation']:.0f} FCFA/jour."
        
        else:
            return f"✅ {user_firstname}, tu gères bien! Continue comme ça. Tu peux dépenser jusqu'à {prediction['daily_budget_recommendation']:.0f} FCFA/jour sans stress 💪"
