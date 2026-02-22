from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean, ForeignKey, Enum as SQLEnum
from sqlalchemy.orm import relationship
from datetime import datetime
import enum
from .database import Base

class PurchaseStatus(str, enum.Enum):
    """
    Cycle de vie d'un achat planifié.
    Permet de distinguer les envies en attente des dépenses réalisées.
    """
    PENDING = "pending"      # En attente de validation ou d'argent
    PURCHASED = "purchased"  # Converti en transaction réelle
    CANCELLED = "cancelled"  # Abandonné pour économiser

class CategoryEnum(str, enum.Enum):
    """Catégories de dépenses"""
    ALIMENTATION = "alimentation"
    TRANSPORT = "transport"
    LOGEMENT = "logement"
    SANTE = "sante"
    EDUCATION = "education"
    LOISIRS = "loisirs"
    EPARGNE = "epargne"
    VETEMENTS = "vetements"
    COMMUNICATION = "communication"
    AUTRE = "autre"

class PlannedPurchase(Base):
    """
    Liste de souhaits ("Wishlist") financière.
    Aide l'utilisateur à différer ses achats pour éviter l'impulsivité.
    """
    __tablename__ = "planned_purchases"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    # Informations sur l'achat
    name = Column(String, nullable=False)  # Ex: "Acheter des chaussures"
    description = Column(String, nullable=True)
    amount = Column(Float, nullable=False)  # Montant prévu
    category = Column(SQLEnum(CategoryEnum), nullable=False)
    
    # Dates
    planned_date = Column(DateTime, nullable=True)  # Date prévue pour l'achat
    created_at = Column(DateTime, default=datetime.utcnow)
    purchased_at = Column(DateTime, nullable=True)  # Date réelle d'achat
    
    # Statut
    status = Column(SQLEnum(PurchaseStatus), default=PurchaseStatus.PENDING)
    
    # Lien avec la transaction réelle (si déjà acheté)
    transaction_id = Column(Integer, ForeignKey("transactions.id"), nullable=True)
    
    # Relations
    user = relationship("User", back_populates="planned_purchases")
    transaction = relationship("Transaction", back_populates="planned_purchase")

    def __repr__(self):
        return f"<PlannedPurchase {self.name} - {self.amount} FCFA ({self.status})>"
