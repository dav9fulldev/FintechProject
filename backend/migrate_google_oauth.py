"""
Script de migration de la base de données pour ajouter le support Google OAuth
"""

from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

# Charger les variables d'environnement
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

def migrate_database():
    """Ajoute les colonnes Google OAuth au modèle User"""
    
    print("🔄 Démarrage de la migration de la base de données...")
    
    engine = create_engine(DATABASE_URL)
    
    migrations = [
        {
            "name": "Rendre hashed_password nullable",
            "sql": "ALTER TABLE users ALTER COLUMN hashed_password DROP NOT NULL;"
        },
        {
            "name": "Ajouter google_id",
            "sql": "ALTER TABLE users ADD COLUMN IF NOT EXISTS google_id VARCHAR UNIQUE;"
        },
        {
            "name": "Ajouter profile_picture",
            "sql": "ALTER TABLE users ADD COLUMN IF NOT EXISTS profile_picture VARCHAR;"
        },
        {
            "name": "Ajouter auth_provider",
            "sql": "ALTER TABLE users ADD COLUMN IF NOT EXISTS auth_provider VARCHAR DEFAULT 'email';"
        },
        {
            "name": "Créer index sur google_id",
            "sql": "CREATE INDEX IF NOT EXISTS idx_users_google_id ON users(google_id);"
        }
    ]
    
    with engine.connect() as conn:
        for migration in migrations:
            try:
                print(f"  ➜ {migration['name']}...", end=" ")
                conn.execute(text(migration['sql']))
                conn.commit()
                print("✅")
            except Exception as e:
                if "already exists" in str(e) or "duplicate" in str(e).lower():
                    print("⏭️  (déjà existant)")
                else:
                    print(f"❌ Erreur: {e}")
                    raise
    
    print("\n✅ Migration terminée avec succès!")
    print("\nLes utilisateurs peuvent maintenant se connecter avec Google.")

if __name__ == "__main__":
    migrate_database()

