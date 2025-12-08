"""
Financial Brain - Moteur d'analyse financière intelligent pour Sika

Responsabilités:
1. Détection des achats impulsifs
2. Analyse des patterns de dépenses
3. Prévisions fin de mois
4. Calcul de risque d'endettement
5. Recommandations personnalisées
6. Alertes proactives
"""

from datetime import datetime, timedelta
from typing import List, Dict, Optional, Tuple
from sqlalchemy.orm import Session
from sqlalchemy import func, and_, extract
from ..models.transaction import Transaction
from ..models.budget import Budget
from ..models.user import User
import statistics


class FinancialBrain:
    """Cerveau financier de Sika - Analyse et conseils IA"""
    
    # Seuils critiques
    IMPULSIVE_THRESHOLD_PERCENT = 20  # >20% du revenu en 24h = impulsif
    IMPULSIVE_FREQUENCY_THRESHOLD = 5  # >5 transactions en 2h = impulsif
    CATEGORY_WARNING_THRESHOLD = 30  # >30% du budget catégorie = alerte
    DEBT_RISK_THRESHOLD = 90  # >90% du budget total = risque dette
    HIGH_SPENDING_THRESHOLD = 70  # >70% du budget = dépenses élevées
    
    def __init__(self, db: Session, user_id: int):
        self.db = db
        self.user_id = user_id
        self.user = db.query(User).filter(User.id == user_id).first()
        
    # ========================================================================
    # 1. DÉTECTION ACHATS IMPULSIFS
    # ========================================================================
    
    def detect_impulsive_purchase(self, amount: float) -> Dict:
        """
        Détecte si un achat est impulsif
        
        Critères:
        - Montant > 20% du revenu mensuel
        - Dépense dans une fenêtre de 24h dépassant 20%
        - Fréquence élevée (>5 transactions en 2h)
        """
        if not self.user or not self.user.monthly_income:
            return {"is_impulsive": False, "reason": None}
        
        monthly_income = self.user.monthly_income
        threshold = monthly_income * (self.IMPULSIVE_THRESHOLD_PERCENT / 100)
        
        # Critère 1: Montant unique > 20% revenu
        if amount > threshold:
            return {
                "is_impulsive": True,
                "severity": "high",
                "reason": f"Cette dépense représente {(amount/monthly_income)*100:.1f}% de ton revenu mensuel",
                "suggestion": f"C'est beaucoup ! Réfléchis bien avant de valider. Maximum conseillé: {threshold:.0f} FCFA",
                "risk_score": min((amount / threshold) * 10, 10)
            }
        
        # Critère 2: Total dépenses 24h > 20% revenu
        yesterday = datetime.utcnow() - timedelta(hours=24)
        recent_spending = self.db.query(func.sum(Transaction.amount)).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= yesterday
            )
        ).scalar() or 0
        
        total_with_new = recent_spending + amount
        if total_with_new > threshold:
            return {
                "is_impulsive": True,
                "severity": "medium",
                "reason": f"Tu as déjà dépensé {recent_spending:.0f} FCFA aujourd'hui",
                "suggestion": f"Cette nouvelle dépense portera ton total à {total_with_new:.0f} FCFA (limite: {threshold:.0f} FCFA)",
                "risk_score": min((total_with_new / threshold) * 8, 10)
            }
        
        # Critère 3: Fréquence élevée (>5 transactions en 2h)
        two_hours_ago = datetime.utcnow() - timedelta(hours=2)
        recent_count = self.db.query(func.count(Transaction.id)).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= two_hours_ago
            )
        ).scalar() or 0
        
        if recent_count >= self.IMPULSIVE_FREQUENCY_THRESHOLD:
            return {
                "is_impulsive": True,
                "severity": "medium",
                "reason": f"C'est ta {recent_count + 1}ème dépense en 2 heures",
                "suggestion": "Tu achètes beaucoup trop vite. Prends une pause, respire ! 🧘",
                "risk_score": 7
            }
        
        return {"is_impulsive": False, "reason": None}
    
    # ========================================================================
    # 2. ANALYSE PATTERNS & CATÉGORIES
    # ========================================================================
    
    def analyze_category_spending(self, category: str, period_days: int = 30) -> Dict:
        """Analyse les dépenses par catégorie"""
        start_date = datetime.utcnow() - timedelta(days=period_days)
        
        # Total dépensé dans cette catégorie
        spent = self.db.query(func.sum(Transaction.amount)).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.category == category,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= start_date
            )
        ).scalar() or 0
        
        # Budget alloué à cette catégorie
        current_month = datetime.utcnow().month
        current_year = datetime.utcnow().year
        
        budget = self.db.query(Budget).filter(
            and_(
                Budget.user_id == self.user_id,
                Budget.category == category,
                extract('month', Budget.start_date) == current_month,
                extract('year', Budget.start_date) == current_year
            )
        ).first()
        
        if not budget:
            return {
                "category": category,
                "spent": spent,
                "budget": None,
                "percentage": None,
                "status": "no_budget",
                "warning": "Aucun budget défini pour cette catégorie"
            }
        
        percentage = (spent / budget.amount) * 100 if budget.amount > 0 else 0
        remaining = budget.amount - spent
        
        # Déterminer le statut
        if percentage >= self.DEBT_RISK_THRESHOLD:
            status = "critical"
            warning = f"🔴 ALERTE ! Tu as dépassé ton budget {category} de {percentage - 100:.0f}%"
        elif percentage >= self.CATEGORY_WARNING_THRESHOLD:
            status = "warning"
            warning = f"⚠️ Attention ! Tu as utilisé {percentage:.0f}% de ton budget {category}"
        elif percentage >= 50:
            status = "caution"
            warning = f"💡 Tu as déjà consommé la moitié de ton budget {category}"
        else:
            status = "good"
            warning = None
        
        return {
            "category": category,
            "spent": spent,
            "budget": budget.amount,
            "remaining": remaining,
            "percentage": percentage,
            "status": status,
            "warning": warning,
            "days_left": (budget.end_date - datetime.utcnow()).days if budget.end_date else None
        }
    
    def get_spending_patterns(self) -> Dict:
        """Identifie les patterns de dépenses"""
        # Derniers 30 jours
        thirty_days_ago = datetime.utcnow() - timedelta(days=30)
        
        # Transactions par jour de la semaine
        transactions = self.db.query(Transaction).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= thirty_days_ago
            )
        ).all()
        
        if not transactions:
            return {"patterns": [], "insights": "Pas assez de données pour analyser tes habitudes"}
        
        # Grouper par jour de la semaine
        weekday_spending = {}
        for tx in transactions:
            day = tx.transaction_date.strftime("%A")
            weekday_spending[day] = weekday_spending.get(day, 0) + tx.amount
        
        # Trouver le jour avec le plus de dépenses
        max_day = max(weekday_spending, key=weekday_spending.get) if weekday_spending else None
        
        # Moyenne journalière
        daily_avg = sum(tx.amount for tx in transactions) / 30
        
        # Catégorie la plus dépensière
        category_spending = {}
        for tx in transactions:
            category_spending[tx.category] = category_spending.get(tx.category, 0) + tx.amount
        
        top_category = max(category_spending, key=category_spending.get) if category_spending else None
        
        return {
            "daily_average": daily_avg,
            "highest_spending_day": max_day,
            "top_category": top_category,
            "top_category_amount": category_spending.get(top_category, 0) if top_category else 0,
            "total_transactions": len(transactions),
            "insights": self._generate_pattern_insights(daily_avg, max_day, top_category)
        }
    
    def _generate_pattern_insights(self, daily_avg: float, max_day: str, top_category: str) -> str:
        """Génère des insights sur les patterns"""
        insights = []
        
        if daily_avg > 0:
            insights.append(f"Tu dépenses en moyenne {daily_avg:.0f} FCFA par jour")
        
        if max_day:
            insights.append(f"Tu dépenses le plus les {max_day}s")
        
        if top_category:
            insights.append(f"Catégorie principale: {top_category}")
        
        return ". ".join(insights)
    
    # ========================================================================
    # 3. PRÉVISIONS FIN DE MOIS
    # ========================================================================
    
    def predict_end_of_month(self) -> Dict:
        """Prévoit les dépenses de fin de mois"""
        current_month = datetime.utcnow().month
        current_year = datetime.utcnow().year
        current_day = datetime.utcnow().day
        
        # Nombre de jours dans le mois
        if current_month == 12:
            next_month = datetime(current_year + 1, 1, 1)
        else:
            next_month = datetime(current_year, current_month + 1, 1)
        
        days_in_month = (next_month - datetime(current_year, current_month, 1)).days
        days_remaining = days_in_month - current_day
        
        # Dépenses du mois en cours
        month_start = datetime(current_year, current_month, 1)
        monthly_spending = self.db.query(func.sum(Transaction.amount)).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= month_start
            )
        ).scalar() or 0
        
        # Budget total du mois
        monthly_budgets = self.db.query(func.sum(Budget.amount)).filter(
            and_(
                Budget.user_id == self.user_id,
                extract('month', Budget.start_date) == current_month,
                extract('year', Budget.start_date) == current_year
            )
        ).scalar() or 0
        
        if monthly_budgets == 0:
            monthly_budgets = self.user.monthly_income if self.user and self.user.monthly_income else 0
        
        # Calcul de la projection
        if current_day > 0:
            daily_avg = monthly_spending / current_day
            projected_total = daily_avg * days_in_month
        else:
            daily_avg = 0
            projected_total = 0
        
        remaining_budget = monthly_budgets - monthly_spending
        projected_remaining = monthly_budgets - projected_total
        
        # Évaluation du risque
        if projected_total > monthly_budgets:
            risk_level = "high"
            status = "danger"
            message = f"⚠️ ALERTE ! Tu risques de dépasser ton budget de {projected_total - monthly_budgets:.0f} FCFA"
        elif (monthly_spending / monthly_budgets) * 100 >= self.HIGH_SPENDING_THRESHOLD:
            risk_level = "medium"
            status = "warning"
            message = "💡 Attention, tu as déjà dépensé beaucoup ce mois-ci"
        else:
            risk_level = "low"
            status = "good"
            message = "✅ Tu es sur la bonne voie !"
        
        # Conseils quotidiens
        daily_budget_remaining = remaining_budget / days_remaining if days_remaining > 0 else 0
        
        return {
            "current_spending": monthly_spending,
            "total_budget": monthly_budgets,
            "remaining_budget": remaining_budget,
            "days_remaining": days_remaining,
            "daily_average_so_far": daily_avg,
            "projected_total": projected_total,
            "projected_remaining": projected_remaining,
            "risk_level": risk_level,
            "status": status,
            "message": message,
            "daily_budget_recommendation": daily_budget_remaining,
            "advice": f"Pour tenir jusqu'à la fin du mois, dépense maximum {daily_budget_remaining:.0f} FCFA par jour"
        }
    
    # ========================================================================
    # 4. CALCUL RISQUE ENDETTEMENT
    # ========================================================================
    
    def calculate_debt_risk(self) -> Dict:
        """Calcule le risque d'endettement"""
        if not self.user or not self.user.monthly_income:
            return {
                "risk_score": 0,
                "risk_level": "unknown",
                "message": "Configure ton revenu mensuel pour cette analyse"
            }
        
        monthly_income = self.user.monthly_income
        
        # Dépenses du mois en cours
        current_month = datetime.utcnow().month
        current_year = datetime.utcnow().year
        month_start = datetime(current_year, current_month, 1)
        
        monthly_spending = self.db.query(func.sum(Transaction.amount)).filter(
            and_(
                Transaction.user_id == self.user_id,
                Transaction.transaction_type == "expense",
                Transaction.transaction_date >= month_start
            )
        ).scalar() or 0
        
        # Ratio dépenses/revenus
        spending_ratio = (monthly_spending / monthly_income) * 100
        
        # Calcul du score de risque (0-10)
        if spending_ratio >= 100:
            risk_score = 10
            risk_level = "critical"
            message = "🔴 DANGER ! Tu dépenses plus que tu ne gagnes"
        elif spending_ratio >= self.DEBT_RISK_THRESHOLD:
            risk_score = 8 + (spending_ratio - 90) / 5
            risk_level = "high"
            message = f"⚠️ Risque élevé ! Tu as utilisé {spending_ratio:.0f}% de ton revenu"
        elif spending_ratio >= self.HIGH_SPENDING_THRESHOLD:
            risk_score = 5 + (spending_ratio - 70) / 4
            risk_level = "medium"
            message = f"💡 Attention ! {spending_ratio:.0f}% de ton revenu déjà dépensé"
        elif spending_ratio >= 50:
            risk_score = 3 + (spending_ratio - 50) / 10
            risk_level = "low"
            message = "✅ Tu gères bien, mais reste vigilant"
        else:
            risk_score = spending_ratio / 25
            risk_level = "very_low"
            message = "🎉 Excellent ! Tu maîtrises bien tes dépenses"
        
        return {
            "risk_score": min(risk_score, 10),
            "risk_level": risk_level,
            "spending_ratio": spending_ratio,
            "monthly_income": monthly_income,
            "monthly_spending": monthly_spending,
            "remaining_income": monthly_income - monthly_spending,
            "message": message,
            "recommendations": self._get_debt_prevention_tips(spending_ratio)
        }
    
    def _get_debt_prevention_tips(self, spending_ratio: float) -> List[str]:
        """Conseils pour éviter l'endettement"""
        tips = []
        
        if spending_ratio >= 90:
            tips.extend([
                "🚨 Arrête toute dépense non essentielle immédiatement",
                "📊 Révise ton budget - il n'est pas adapté",
                "💰 Cherche des revenus complémentaires",
                "🏦 Évite absolument les prêts"
            ])
        elif spending_ratio >= 70:
            tips.extend([
                "⏸️ Ralentis tes dépenses",
                "📝 Fais la liste de ce qui est vraiment essentiel",
                "🎯 Concentre-toi sur tes objectifs d'épargne",
                "🛍️ Évite les achats impulsifs"
            ])
        elif spending_ratio >= 50:
            tips.extend([
                "✅ Continue comme ça, tu gères bien",
                "💡 Pense à épargner le reste",
                "📈 Garde cette discipline jusqu'à la fin du mois"
            ])
        else:
            tips.extend([
                "🎉 Bravo ! Tu es un champion de la gestion",
                "💰 Profite pour épargner davantage",
                "🎯 Investis dans tes objectifs long terme"
            ])
        
        return tips
    
    # ========================================================================
    # 5. RECOMMANDATIONS PERSONNALISÉES
    # ========================================================================
    
    def get_personalized_recommendations(self) -> List[Dict]:
        """Génère des recommandations personnalisées"""
        recommendations = []
        
        # 1. Analyse du risque global
        debt_risk = self.calculate_debt_risk()
        if debt_risk["risk_level"] in ["high", "critical"]:
            recommendations.append({
                "type": "urgent",
                "category": "debt_risk",
                "title": "Risque d'endettement détecté",
                "message": debt_risk["message"],
                "action": "reduce_spending",
                "priority": 1
            })
        
        # 2. Prévision fin de mois
        prediction = self.predict_end_of_month()
        if prediction["risk_level"] == "high":
            recommendations.append({
                "type": "warning",
                "category": "budget_forecast",
                "title": "Prévision budgétaire inquiétante",
                "message": prediction["message"],
                "action": "adjust_budget",
                "priority": 2,
                "advice": prediction["advice"]
            })
        
        # 3. Analyse des catégories
        categories = ["alimentation", "transport", "loisirs", "logement", "santé"]
        for category in categories:
            analysis = self.analyze_category_spending(category)
            if analysis["status"] in ["warning", "critical"]:
                recommendations.append({
                    "type": "category_alert",
                    "category": category,
                    "title": f"Budget {category} en alerte",
                    "message": analysis["warning"],
                    "action": "review_category",
                    "priority": 3 if analysis["status"] == "critical" else 4
                })
        
        # 4. Patterns de dépenses
        patterns = self.get_spending_patterns()
        if patterns["daily_average"] > 0:
            recommendations.append({
                "type": "insight",
                "category": "spending_pattern",
                "title": "Analyse de tes habitudes",
                "message": patterns["insights"],
                "action": "review_habits",
                "priority": 5
            })
        
        # Trier par priorité
        recommendations.sort(key=lambda x: x["priority"])
        
        return recommendations
    
    # ========================================================================
    # 6. ANALYSE COMPLÈTE (pour Sika conversationnel)
    # ========================================================================
    
    def get_full_financial_analysis(self) -> Dict:
        """Analyse financière complète pour alimenter Sika LLM"""
        return {
            "user": {
                "id": self.user_id,
                "username": self.user.username if self.user else "Inconnu",
                "monthly_income": self.user.monthly_income if self.user else 0
            },
            "debt_risk": self.calculate_debt_risk(),
            "end_of_month_prediction": self.predict_end_of_month(),
            "spending_patterns": self.get_spending_patterns(),
            "recommendations": self.get_personalized_recommendations(),
            "categories_analysis": {
                cat: self.analyze_category_spending(cat)
                for cat in ["alimentation", "transport", "loisirs", "logement", "santé", "autres"]
            }
        }
