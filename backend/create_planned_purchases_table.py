"""
Script de migration pour créer la table planned_purchases
"""
import psycopg2
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("❌ DATABASE_URL introuvable dans le fichier .env")

engine = create_engine(DATABASE_URL)

def create_planned_purchases_table():
    """Créer la table planned_purchases"""
    try:
        conn = psycopg2.connect(DATABASE_URL)
        cur = conn.cursor()
        
        cur.execute("""
            CREATE TABLE IF NOT EXISTS planned_purchases (
                id SERIAL PRIMARY KEY,
                user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                name VARCHAR NOT NULL,
                description VARCHAR,
                amount DOUBLE PRECISION NOT NULL,
                category VARCHAR NOT NULL,
                planned_date TIMESTAMP,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                purchased_at TIMESTAMP,
                status VARCHAR DEFAULT 'pending',
                transaction_id INTEGER REFERENCES transactions(id)
            )
        """)

        cur.execute("""
            CREATE INDEX IF NOT EXISTS idx_planned_purchases_user_id 
            ON planned_purchases(user_id)
        """)

        cur.execute("""
            CREATE INDEX IF NOT EXISTS idx_planned_purchases_status 
            ON planned_purchases(status)
        """)

        conn.commit()
        print("✅ Table planned_purchases créée avec succès")

        cur.close()
        conn.close()

    except Exception as e:
        print(f"❌ Erreur lors de la création de la table: {e}")

if __name__ == "__main__":
    create_planned_purchases_table()
