from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

# Configuration de la base de données SQLAlchemy
# Utilise des variables d'environnement pour la sécurité des identifiants
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

# Moteur de base de données : fait le lien entre Python et Postgres
engine = create_engine(DATABASE_URL)

# Usine à sessions : permet de créer des transactions avec la DB
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Classe de base pour les modèles ORM
Base = declarative_base()

def get_db():
    """
    Générateur de session de base de données (Dépendance FastAPI).
    Assure que chaque requête a sa propre session et qu'elle est fermée à la fin.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()