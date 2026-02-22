from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey, Enum, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from .database import Base
from .budget import CategoryEnum


class Transaction(Base):
    """
    Objet central du flux financier.
    Enregistre chaque mouvement d'argent et l'analyse IA associée.
    """
    __tablename__ = "transactions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    amount = Column(Float, nullable=False)
    category = Column(Enum(CategoryEnum), nullable=False)
    description = Column(String)
    
    # Type : 'expense' (dépense) ou 'income' (entrée d'argent)
    transaction_type = Column(String, default="expense")
    
    # Feedback IA : score de pertinence et conseil personnalisé
    ai_score = Column(Float)
    ai_recommendation = Column(String)
    
    # Sécurité : flag indiquant si la dépense a été approuvée par l'utilisateur (ou forcée)
    was_approved = Column(Boolean, default=True)
    
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    
    # Relation avec PlannedPurchase (si cette transaction correspond à un achat planifié)
    planned_purchase = relationship("PlannedPurchase", back_populates="transaction", uselist=False)
