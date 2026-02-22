from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey, Boolean
from sqlalchemy.sql import func
from .database import Base


class Goal(Base):
    """
    Représente un objectif d'épargne à long terme (ex: Achat terrain, Mariage).
    Permet de suivre la progression et de motiver l'utilisateur.
    """
    __tablename__ = "goals"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    name = Column(String, nullable=False)
    description = Column(String)
    target_amount = Column(Float, nullable=False) # Montant total à atteindre
    current_amount = Column(Float, default=0.0)    # Montant déjà mis de côté
    target_date = Column(DateTime(timezone=True))   # Date limite prévisionnelle
    
    # Personnalisation UI
    icon = Column(String, default="flag")
    color = Column(String, default="#00A86B")
    
    # État de l'objectif
    is_completed = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
