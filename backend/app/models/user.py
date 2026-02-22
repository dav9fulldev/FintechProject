from sqlalchemy import Column, Integer, String, DateTime, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from .database import Base

class User(Base):
    """
    Représente un utilisateur de l'application GèrTonArgent.
    Stocke les informations d'authentification et le profil socio-économique.
    """
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    phone = Column(String, unique=True, index=True)
    username = Column(String, unique=True, index=True)
    
    # Informations de profil pour la personnalisation par l'IA
    first_name = Column(String)
    last_name = Column(String)
    profession = Column(String)
    income_range = Column(String) # Ex: "50k-100k FCFA"
    
    # Sécurité : stocke le hash bcrypt, JAMAIS le mot de passe en clair
    hashed_password = Column(String, nullable=False)
    
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
    
    # Relations
    planned_purchases = relationship("PlannedPurchase", back_populates="user", cascade="all, delete-orphan")